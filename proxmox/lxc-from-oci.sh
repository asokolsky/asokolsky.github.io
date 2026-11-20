#!/usr/bin/env bash
# Create, check, upgrade, and recover script-managed Proxmox OCI containers.

set -Eeuo pipefail

oci_die() {
    printf 'Error: %s\n' "$*" >&2
    exit 1
}

oci_require_tools() {
    local command_name
    for command_name in "$@"; do
        command -v "$command_name" >/dev/null || oci_die "Missing command: $command_name"
    done
}

oci_init() {
    local value
    oci_require_tools pvesh jq timeout
    [[ $(id -u) == 0 ]] || oci_die 'Run on the Proxmox node as root.'
    NODE=$(hostname -s)
    COMMAND_TIMEOUT=${OCI_COMMAND_TIMEOUT:-120}
    TASK_TIMEOUT=${OCI_TASK_TIMEOUT:-600}
    VERIFY_TIMEOUT=${OCI_VERIFY_TIMEOUT:-60}
    for value in "$COMMAND_TIMEOUT" "$TASK_TIMEOUT" "$VERIFY_TIMEOUT"; do
        [[ $value =~ ^[1-9][0-9]*$ ]] || oci_die 'Timeouts must be positive integer seconds.'
    done
}

oci_lock() {
    STATE_DIR=${OCI_STATE_DIR:-/var/lib/lxc-from-oci}
    [[ $STATE_DIR == /* ]] || oci_die 'OCI_STATE_DIR must be absolute.'
    mkdir -p -- "$STATE_DIR"
    chmod 0700 "$STATE_DIR"
    exec 9> "$STATE_DIR/$CTID.lock"
    flock -n 9 || oci_die "Another operation holds CT $CTID."
    if [[ -n ${NEW_CTID:-} ]]; then
        exec 8> "$STATE_DIR/$NEW_CTID.lock"
        flock -n 8 || oci_die "Another operation holds CT $NEW_CTID."
    fi
}

oci_api() {
    timeout --kill-after=5 "$COMMAND_TIMEOUT" pvesh "$@" </dev/null
}

oci_pct() {
    timeout --kill-after=5 "$COMMAND_TIMEOUT" pct "$@" </dev/null
}

oci_validate_id() {
    [[ $1 =~ ^[1-9][0-9]{2,8}$ ]] || oci_die "Invalid CT ID: $1"
}

oci_validate_settings() {
    local key value
    [[ $(jq -r .version <<< "$SETTINGS") == 1 ]] || oci_die 'Unsupported OCI settings version.'
    [[ $(oci_setting node) == "$NODE" ]] || oci_die 'Run on the original installation node.'
    IMAGE_REF=$(oci_setting image_ref)
    DATA_DIR=$(oci_setting data_dir)
    [[ $IMAGE_REF =~ ^[^[:space:]@]+:[a-zA-Z0-9_][a-zA-Z0-9_.-]*$ ]] ||
        oci_die 'Use an image reference with a tag, for example docker.io/library/debian:latest.'
    [[ $DATA_DIR == /* && $DATA_DIR != *','* && $DATA_DIR != *$'\n'* ]] ||
        oci_die 'The data directory must be an absolute path without commas or newlines.'
    for key in root_storage template_storage bridge; do
        value=$(oci_setting "$key")
        [[ $value =~ ^[a-zA-Z0-9][a-zA-Z0-9_.-]*$ ]] || oci_die "Invalid $key: $value"
    done
    [[ $(oci_setting stop_mode) == stop || $(oci_setting stop_mode) == shutdown ]] ||
        oci_die 'Stop mode must be stop or shutdown.'
    for key in address gateway; do
        value=$(oci_setting "$key")
        [[ -n $value && $value != *','* && $value != *[[:space:]]* ]] || oci_die "Invalid $key"
    done
    [[ -n $(oci_setting entrypoint) && -n $(oci_setting verify_command) ]] ||
        oci_die 'Entrypoint and verification command must not be empty.'
}

oci_setting() {
    jq -er --arg key "$1" '.[$key] | select(. != null)' <<< "$SETTINGS"
}

oci_config() {
    oci_api get "/nodes/$NODE/lxc/$1/config" --output-format json
}

oci_state() {
    oci_api get "/nodes/$NODE/lxc/$1/status/current" --output-format json | jq -er .status
}

# Exclude only metadata and the boot flag that the upgrade itself changes.
oci_base_config() {
    jq -cS 'del(.description, .digest, .onboot)'
}

oci_note() {
    jq -er --arg key "$1" '
      [.description // "" | split("\n")[] |
       select(startswith($key + "=")) | ltrimstr($key + "=")] |
      if length == 1 then .[0] else error("Missing or duplicate note: " + $key) end
    ' <<< "$CT_CONFIG"
}

oci_load() {
    CT_CONFIG=$(oci_config "$1")
    CURRENT_IMAGE=$(oci_note CURRENT_IMAGE)
    DEPLOYED_FINGERPRINT=$(oci_note DEPLOYED_FINGERPRINT)
    SETTINGS=$(oci_note OCI_SETTINGS | jq -ce 'select(type == "object")')
    BASE_CONFIG=$(oci_note OCI_BASE_CONFIG | jq -cSe 'select(type == "object")')
    [[ $CURRENT_IMAGE == /* ]] || oci_die 'Invalid CURRENT_IMAGE note.'
    [[ $DEPLOYED_FINGERPRINT =~ ^[a-f0-9]{64}$ ]] || oci_die 'Invalid deployed fingerprint.'
    oci_validate_settings
}

# Replace our metadata lines, retaining free-form notes and other metadata.
oci_save() {
    local id=$1 path=$2 fingerprint=$3 config=$4 base=$5 description
    description=$(jq -er --arg path "$path" --arg fingerprint "$fingerprint" \
        --arg settings "$SETTINGS" --arg base "$base" '
      (.description // "" | split("\n") |
       map(select(test("^(CURRENT_IMAGE|DEPLOYED_FINGERPRINT|OCI_SETTINGS|OCI_BASE_CONFIG)=") | not))) +
      ["CURRENT_IMAGE=" + $path, "DEPLOYED_FINGERPRINT=" + $fingerprint,
       "OCI_SETTINGS=" + $settings, "OCI_BASE_CONFIG=" + $base] | join("\n")
    ' <<< "$config")
    oci_pct set "$id" --description "$description"
}

oci_fingerprint() {
    timeout --kill-after=5 "$COMMAND_TIMEOUT" skopeo inspect --config "$1" </dev/null |
        jq -cS . | sha256sum | cut -d ' ' -f 1
}

# This reads only the registry; the deployed archive is never inspected here.
oci_detect() {
    REMOTE_FINGERPRINT=$(oci_fingerprint "docker://$IMAGE_REF")
    if [[ $DEPLOYED_FINGERPRINT == "$REMOTE_FINGERPRINT" ]]; then
        UPDATE_AVAILABLE=0
        printf 'CT %s: image unchanged (%s).\n' "$CTID" "$IMAGE_REF"
    else
        UPDATE_AVAILABLE=1
        printf 'CT %s: update available (%s).\n' "$CTID" "$IMAGE_REF"
    fi
}

oci_pull() {
    local id=$1 expected=${2:-} storage name task status started fingerprint registry output remaining call_timeout
    storage=$(oci_setting template_storage)
    name="lxc-$id-$(date -u +%Y%m%dT%H%M%S)-$$"
    started=$SECONDS
    printf 'Pulling %s into %s:vztmpl/%s.tar\n' "$IMAGE_REF" "$storage" "$name"
    # pvesh may run the worker synchronously and mix progress with its JSON result.
    if ! output=$(timeout --kill-after=5 "$TASK_TIMEOUT" pvesh create \
        "/nodes/$NODE/storage/$storage/oci-registry-pull" \
        --reference "$IMAGE_REF" --filename "$name" --output-format json </dev/null); then
        printf '%s\n' "$output" >&2
        oci_die "Image pull failed or timed out; inspect node tasks for $name.tar before retrying."
    fi
    task=$(printf '%s\n' "$output" | jq -Rser '
      [split("\n")[] | fromjson? |
       select(type == "string" and startswith("UPID:"))] |
      if length == 1 then .[0] else error("Expected one image-pull task ID") end')
    printf 'Pull task: %s\n' "$task"
    while :; do
        remaining=$(( TASK_TIMEOUT - (SECONDS - started) ))
        (( remaining > 0 )) || oci_die "Timed out waiting for $task; inspect its status/log before retrying."
        call_timeout=$(( remaining < COMMAND_TIMEOUT ? remaining : COMMAND_TIMEOUT ))
        status=$(timeout --kill-after=5 "$call_timeout" pvenode task status "$task" --output-format json </dev/null)
        case $(jq -er .status <<< "$status") in
            stopped)
                if [[ $(jq -r '.exitstatus // ""' <<< "$status") != OK ]]; then
                    timeout --kill-after=5 "$COMMAND_TIMEOUT" pvenode task log "$task" </dev/null >&2 || true
                    oci_die "Image pull failed: $task"
                fi
                break
                ;;
            running) ;;
            *) oci_die "Unexpected task status: $status" ;;
        esac
        (( SECONDS - started < TASK_TIMEOUT )) ||
            oci_die "Timed out waiting for $task; inspect its status/log before retrying."
        sleep 2
    done
    TEMPLATE="$storage:vztmpl/$name.tar"
    PULLED_IMAGE=$(timeout --kill-after=5 "$COMMAND_TIMEOUT" pvesm path "$TEMPLATE" </dev/null)
    fingerprint=$(oci_fingerprint "oci-archive:$PULLED_IMAGE")
    registry=$(oci_fingerprint "docker://$IMAGE_REF")
    [[ $fingerprint == "$registry" ]] ||
        oci_die 'Archive/registry fingerprints differ. Check the archive, architecture, and tag movement; do not deploy.'
    [[ -z $expected || $fingerprint == "$expected" ]] ||
        oci_die 'The image changed after detection. Rerun the upgrade to detect and pull it again.'
    PULLED_FINGERPRINT=$fingerprint
}

oci_create_container() {
    local id=$1
    oci_pct create "$id" "$TEMPLATE" \
        --hostname "$(oci_setting hostname)" --unprivileged 1 \
        --cores 1 --memory 256 --swap 0 \
        --rootfs "$(oci_setting root_storage):2" \
        --net0 "name=eth0,bridge=$(oci_setting bridge),ip=$(oci_setting address),gw=$(oci_setting gateway),host-managed=1" \
        --mp0 "$DATA_DIR,mp=/mnt/example,ro=1" --onboot 0
    # OCI extraction can overwrite --entrypoint supplied to pct create.
    oci_pct set "$id" --entrypoint "$(oci_setting entrypoint)"
}

oci_verify() {
    local id=$1 started verification
    verification=$(oci_setting verify_command) || return
    started=$SECONDS
    while :; do
        if [[ $(oci_state "$id") == running ]] &&
            timeout --kill-after=5 10 pct exec "$id" -- /bin/sh -ec "$verification" </dev/null; then
            return 0
        fi
        (( SECONDS - started < VERIFY_TIMEOUT )) || break
        sleep 2
    done
    printf 'Verification failed for CT %s.\n' "$id" >&2
    return 1
}

oci_stop() {
    local id=$1 mode=$2 state
    state=$(oci_state "$id") || return
    if [[ $state != stopped ]]; then
        if [[ $mode == shutdown ]]; then
            oci_pct shutdown "$id" --timeout 60 --forceStop 0 || return
        else
            oci_pct stop "$id" || return
        fi
    fi
    state=$(oci_state "$id") || return
    [[ $state == stopped ]]
}

# An absent replacement is valid; API failures and another node/type are not.
oci_replacement_state() {
    local resources
    resources=$(oci_api get /cluster/resources --type vm --output-format json) || return
    REPLACEMENT_STATE=$(jq -er --argjson id "$NEW_CTID" --arg node "$NODE" '
      [.[] | select(.vmid == $id)] |
      if length == 0 then "absent"
      elif length == 1 and .[0].type == "lxc" and .[0].node == $node then "present"
      else error("Replacement ID belongs to another node or guest type") end
    ' <<< "$resources") || return
}

# Shared by the upgrade EXIT trap and the explicit recover subcommand.
# Explicit error returns are required because callers may use this in an if.
oci_restore_old() {
    local state
    oci_replacement_state || return
    if [[ $REPLACEMENT_STATE == present ]]; then
        oci_pct set "$NEW_CTID" --onboot 0 || return
        if ! oci_stop "$NEW_CTID" "$STOP_MODE"; then
            printf 'Replacement is not confirmed stopped; refusing to start the old CT with the same IP.\n' >&2
            return 1
        fi
    else
        printf 'Replacement CT %s is absent; recovering the old CT only.\n' "$NEW_CTID"
    fi
    state=$(oci_state "$OLD_CTID") || return
    case $state in
        stopped) oci_pct start "$OLD_CTID" || return ;;
        running) ;;
        *) printf 'Cannot determine the old CT state; inspect it manually.\n' >&2; return 1 ;;
    esac
    if ! oci_verify "$OLD_CTID"; then
        state=$(oci_state "$OLD_CTID") || state=unknown
        printf 'Old CT %s failed verification (state: %s). Its boot flag was not restored; inspect it with pct config.\n' "$OLD_CTID" "$state" >&2
        return 1
    fi
    oci_pct set "$OLD_CTID" --onboot "$OLD_ONBOOT" || return
    printf 'Old CT %s restored and verified.\n' "$OLD_CTID"
}

oci_create_usage() {
    cat <<'USAGE'
Usage: lxc-from-oci.sh create CTID [IMAGE_REF] --address CIDR --gateway IP [options]

IMAGE_REF defaults to docker.io/library/debian:latest.
Options:
  --bridge NAME             Default: vmbr0
  --root-storage ID         Default: local-lvm (2 GiB root disk)
  --template-storage ID     Default: local
  --data-dir PATH           Default: /srv/lxc-CTID-data; must not exist
  --entrypoint COMMAND      Default: /bin/sleep infinity
  --verify-command COMMAND  POSIX /bin/sh command executed inside the container
  --stop-mode stop|shutdown Default: stop, suitable for the sleep demonstration

This script uses one read-only bind mount at /mnt/example. It does not manage
arbitrary existing LXCs. See lxc-from-oci.md for scope and rollback.
USAGE
}

oci_create() {
    if [[ ${1:-} == --help || ${1:-} == -h ]]; then oci_create_usage; exit 0; fi
    (( $# >= 1 )) || { oci_create_usage >&2; exit 2; }
    CTID=$1
    shift
    oci_validate_id "$CTID"
    IMAGE_REF=docker.io/library/debian:latest
    if [[ $# -gt 0 && $1 != --* ]]; then IMAGE_REF=$1; shift; fi
    BRIDGE=vmbr0
    ROOT_STORAGE=local-lvm
    TEMPLATE_STORAGE=local
    DATA_DIR="/srv/lxc-$CTID-data"
    ENTRYPOINT='/bin/sleep infinity'
    # Expansion belongs to the shell inside the container, not this host shell.
    # shellcheck disable=SC2016
    VERIFY_COMMAND='test "$(cat /mnt/example/message.txt)" = "Hello from an OCI image in LXC."; cat /etc/os-release; dpkg-query -W base-files'
    STOP_MODE=stop
    ADDRESS=
    GATEWAY=
    while (( $# )); do
        (( $# >= 2 )) || oci_die "Missing value for $1"
        case $1 in
            --address) ADDRESS=$2 ;;
            --gateway) GATEWAY=$2 ;;
            --bridge) BRIDGE=$2 ;;
            --root-storage) ROOT_STORAGE=$2 ;;
            --template-storage) TEMPLATE_STORAGE=$2 ;;
            --data-dir) DATA_DIR=$2 ;;
            --entrypoint) ENTRYPOINT=$2 ;;
            --verify-command) VERIFY_COMMAND=$2 ;;
            --stop-mode) STOP_MODE=$2 ;;
            *) oci_die "Unknown option: $1" ;;
        esac
        shift 2
    done
    oci_init
    oci_require_tools skopeo sha256sum pct pvesm pvenode tar flock
    SETTINGS=$(jq -nc --arg node "$NODE" --arg image_ref "$IMAGE_REF" \
        --arg data_dir "$DATA_DIR" --arg bridge "$BRIDGE" --arg address "$ADDRESS" \
        --arg gateway "$GATEWAY" --arg root_storage "$ROOT_STORAGE" \
        --arg template_storage "$TEMPLATE_STORAGE" --arg entrypoint "$ENTRYPOINT" \
        --arg verify_command "$VERIFY_COMMAND" --arg stop_mode "$STOP_MODE" \
        --arg hostname "oci-$CTID" '$ARGS.named + {version: 1}')
    oci_validate_settings
    oci_lock
    oci_api get /cluster/nextid --vmid "$CTID" >/dev/null
    [[ ! -e $DATA_DIR && ! -L $DATA_DIR ]] || oci_die "Data directory already exists: $DATA_DIR"
    oci_pull "$CTID"
    mkdir -m 0755 -- "$DATA_DIR"
    chmod 0755 "$DATA_DIR"
    printf '%s\n' 'Hello from an OCI image in LXC.' > "$DATA_DIR/message.txt"
    chmod 0644 "$DATA_DIR/message.txt"
    trap 'code=$?; if (( code )); then printf "Creation failed; inspect CT %s and retained archive %s. No resources were deleted.\n" "$CTID" "$PULLED_IMAGE" >&2; fi' EXIT
    oci_create_container "$CTID"
    oci_pct start "$CTID"
    oci_verify "$CTID"
    CONFIG=$(oci_config "$CTID")
    BASE_CONFIG=$(oci_base_config <<< "$CONFIG")
    oci_save "$CTID" "$PULLED_IMAGE" "$PULLED_FINGERPRINT" "$CONFIG" "$BASE_CONFIG"
    oci_pct set "$CTID" --onboot 1
    printf 'Created CT %s. Data: %s; archive: %s\n' "$CTID" "$DATA_DIR" "$PULLED_IMAGE"
}

oci_check() {
    if [[ ${1:-} == --help || ${1:-} == -h ]]; then
        printf 'Usage: lxc-from-oci.sh check CTID\nExit: 0 unchanged, 10 update available; other nonzero values indicate errors.\n'
        exit 0
    fi
    [[ $# == 1 ]] || { printf 'Usage: lxc-from-oci.sh check CTID\n' >&2; exit 2; }
    CTID=$1
    oci_validate_id "$CTID"
    oci_init
    oci_require_tools skopeo sha256sum
    oci_load "$CTID"
    oci_detect
    if (( UPDATE_AVAILABLE )); then exit 10; fi
}

oci_upgrade() {
    if [[ ${1:-} == --help || ${1:-} == -h ]]; then
        printf 'Usage: lxc-from-oci.sh upgrade OLD_CTID NEW_CTID\nUnchanged images exit 0 without creating a replacement.\n'
        exit 0
    fi
    [[ $# == 2 ]] || { printf 'Usage: lxc-from-oci.sh upgrade OLD_CTID NEW_CTID\n' >&2; exit 2; }
    CTID=$1
    NEW_CTID=$2
    oci_validate_id "$CTID"
    oci_validate_id "$NEW_CTID"
    [[ $CTID != "$NEW_CTID" ]] || oci_die 'Old and new CT IDs must differ.'
    oci_init
    oci_require_tools skopeo sha256sum pct pvesm pvenode tar flock
    oci_lock
    oci_load "$CTID"
    oci_detect
    (( UPDATE_AVAILABLE )) || exit 0
    oci_api get /cluster/nextid --vmid "$NEW_CTID" >/dev/null
    [[ $(oci_state "$CTID") == running ]] || oci_die 'The source container must be running.'
    [[ $(oci_base_config <<< "$CT_CONFIG") == "$BASE_CONFIG" ]] ||
        oci_die 'Container configuration changed since creation. Review the settings before replacing it.'
    [[ -f $CURRENT_IMAGE && -d $DATA_DIR ]] || oci_die 'The deployed archive or data directory is missing.'
    OLD_CTID=$CTID
    OLD_CONFIG=$CT_CONFIG
    OLD_ONBOOT=$(jq -r '.onboot // 0' <<< "$CT_CONFIG")
    STOP_MODE=$(oci_setting stop_mode)
    RECORD_DIR=$(mktemp -d "$STATE_DIR/upgrade-$OLD_CTID-XXXXXXXX")
    printf '%s\n' "$OLD_CONFIG" > "$RECORD_DIR/old-config.json"
    jq -n --arg node "$NODE" --argjson old "$OLD_CTID" --argjson new "$NEW_CTID" \
        --argjson onboot "$OLD_ONBOOT" --arg mode "$STOP_MODE" \
        --arg verify "$(oci_setting verify_command)" \
        '{node:$node, old_ctid:$old, new_ctid:$new, old_onboot:$onboot, stop_mode:$mode, verify_command:$verify}' \
        > "$RECORD_DIR/upgrade.json"
    cp -- "$CURRENT_IMAGE" "$RECORD_DIR/old-image.tar"
    tar -C "$DATA_DIR" -czf "$RECORD_DIR/data.tar.gz" .
    oci_save "$OLD_CTID" "$RECORD_DIR/old-image.tar" "$DEPLOYED_FINGERPRINT" "$OLD_CONFIG" "$BASE_CONFIG"
    printf 'Recovery record: %s\n' "$RECORD_DIR"
    oci_pull "$NEW_CTID" "$REMOTE_FINGERPRINT"

    CUTOVER_STARTED=0
    UPGRADE_DONE=0
    rollback_on_exit() {
        local code=$?
        trap - EXIT INT TERM
        if (( code == 0 || UPGRADE_DONE || ! CUTOVER_STARTED )); then return; fi
        set +e
        printf 'Upgrade interrupted/failed; restoring CT %s. Recovery record: %s\n' "$OLD_CTID" "$RECORD_DIR" >&2
        if ! oci_restore_old; then
            printf 'Automatic recovery incomplete. Inspect both CTs, then run: lxc-from-oci.sh recover %q\n' "$RECORD_DIR" >&2
        fi
        exit "$code"
    }
    trap rollback_on_exit EXIT
    trap 'exit 130' INT
    trap 'exit 143' TERM

    oci_create_container "$NEW_CTID"
    # Refresh source state before cutover, so concurrent configuration edits fail closed.
    LATEST_CONFIG=$(oci_config "$OLD_CTID")
    [[ $(oci_base_config <<< "$LATEST_CONFIG") == "$BASE_CONFIG" ]] ||
        oci_die 'Source configuration changed while preparing the replacement.'
    [[ $(jq -r '.onboot // 0' <<< "$LATEST_CONFIG") == "$OLD_ONBOOT" ]] ||
        oci_die 'Source automatic startup setting changed while preparing the replacement.'
    CUTOVER_STARTED=1
    oci_stop "$OLD_CTID" "$STOP_MODE"
    oci_pct start "$NEW_CTID"
    oci_verify "$NEW_CTID"
    NEW_CONFIG=$(oci_config "$NEW_CTID")
    # Carry free-form Notes forward; oci_save replaces the reserved metadata lines.
    NEW_CONFIG=$(jq --arg description "$(jq -r '.description // ""' <<< "$LATEST_CONFIG")" \
        '.description = $description' <<< "$NEW_CONFIG")
    NEW_BASE=$(oci_base_config <<< "$NEW_CONFIG")
    oci_save "$NEW_CTID" "$PULLED_IMAGE" "$PULLED_FINGERPRINT" "$NEW_CONFIG" "$NEW_BASE"
    oci_pct set "$OLD_CTID" --onboot 0
    oci_pct set "$NEW_CTID" --onboot "$OLD_ONBOOT"
    UPGRADE_DONE=1
    printf 'Upgraded CT %s to CT %s. Old CT retained stopped. Recovery record: %s\n' "$OLD_CTID" "$NEW_CTID" "$RECORD_DIR"
}

oci_recover() {
    if [[ ${1:-} == --help || ${1:-} == -h ]]; then
        printf 'Usage: lxc-from-oci.sh recover RECORD_DIR\nRestore the old CT from an upgrade record on the original node.\n'
        exit 0
    fi
    [[ $# == 1 ]] || { printf 'Usage: lxc-from-oci.sh recover RECORD_DIR\n' >&2; exit 2; }
    [[ -d $1 ]] || oci_die "Recovery directory does not exist: $1"
    RECORD_DIR=$(cd -- "$1" && pwd -P)
    oci_init
    oci_require_tools pct flock
    local record
    record=$(jq -ce 'select(type == "object")' "$RECORD_DIR/upgrade.json")
    [[ $(jq -er .node <<< "$record") == "$NODE" ]] || oci_die 'Run recovery on the recorded Proxmox node.'
    OLD_CTID=$(jq -er .old_ctid <<< "$record")
    NEW_CTID=$(jq -er .new_ctid <<< "$record")
    OLD_ONBOOT=$(jq -er .old_onboot <<< "$record")
    STOP_MODE=$(jq -er .stop_mode <<< "$record")
    # Verification comes from the record, so damaged Notes cannot block recovery.
    SETTINGS=$(jq -ce '
      if (.verify_command | type) != "string" then
        error("Recovery verify_command must be a nonblank string")
      elif (.verify_command | test("[^[:space:]]") | not) then
        error("Recovery verify_command must be a nonblank string")
      else {verify_command: .verify_command} end
    ' <<< "$record")
    oci_validate_id "$OLD_CTID"
    oci_validate_id "$NEW_CTID"
    [[ $OLD_CTID != "$NEW_CTID" ]] || oci_die 'Old and new CT IDs must differ.'
    [[ $OLD_ONBOOT == 0 || $OLD_ONBOOT == 1 ]] || oci_die 'Invalid old_onboot in the recovery record.'
    [[ $STOP_MODE == stop || $STOP_MODE == shutdown ]] || oci_die 'Invalid stop_mode in the recovery record.'
    CTID=$OLD_CTID
    oci_lock
    if ! oci_restore_old; then
        oci_die "Recovery incomplete. Inspect both CTs and the record in $RECORD_DIR."
    fi
}

oci_usage() {
    cat <<'USAGE'
Usage:
  lxc-from-oci.sh create CTID [IMAGE_REF] --address CIDR --gateway IP [options]
  lxc-from-oci.sh check CTID
  lxc-from-oci.sh upgrade OLD_CTID NEW_CTID
  lxc-from-oci.sh recover RECORD_DIR

Use lxc-from-oci.sh COMMAND --help for command-specific options.
USAGE
}

COMMAND=${1:-}
if (( $# )); then shift; fi
case $COMMAND in
    create) oci_create "$@" ;;
    check) oci_check "$@" ;;
    upgrade) oci_upgrade "$@" ;;
    recover) oci_recover "$@" ;;
    --help|-h) oci_usage ;;
    "") oci_usage >&2; exit 2 ;;
    *) printf 'Unknown command: %s\n' "$COMMAND" >&2; oci_usage >&2; exit 2 ;;
esac
