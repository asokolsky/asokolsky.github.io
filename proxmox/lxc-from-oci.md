# LXC from an OCI Image

LXC is great. That is until you need to maintain it. So how about this:

- Use Proxmox VE's native OCI support to create an LXC from a published image.
- Keep application data outside the disposable root filesystem.
- Record the image fingerprint and creation settings in the LXC's Notes.
- Check the mutable tag before pulling a replacement.
- Keep the previous container available for rollback.

The example uses `debian:latest`.

## Prerequisites

Creation, startup, and `check` were live-tested on Proxmox VE 9.2.31 with
`skopeo` 1.18.0 and `debian:latest` on amd64. The intended target is Proxmox VE
9.1 or later with native OCI support; other versions, live upgrade, and live
recovery remain unvalidated. Validate image compatibility and the post-creation
check on your node before relying on upgrades.

You need:

- Root access to an updated Proxmox node.
- An image matching that node's architecture and access to its registry.
- Template storage (`local` by default), root disk storage (`local-lvm` by default),
  a bridge, an available CT ID, and an unused static address.
- [`skopeo`](https://github.com/containers/skopeo), `jq`, and the standard
  Proxmox CLI tools.

Docker Engine is not required. Bash, `flock` (from `util-linux`), and `timeout`
(from `coreutils`) are normally already installed on Proxmox. Install the
additional tools on the node:

```bash
apt update
apt install skopeo jq
```

Docker Hub's anonymous rate limits apply to inspections and pulls. Authenticate
as root with `skopeo login docker.io` if required.

Docker Compose settings, published ports, and
health checks need explicit equivalents in Proxmox.

## Install the Script

Set `REVIEWED_COMMIT` to the full 40-character SHA of the revision you intend to
review, then download those exact bytes on the Proxmox node:

```bash
REVIEWED_COMMIT=FULL_40_CHARACTER_COMMIT_SHA
curl -fsSL \
  "https://raw.githubusercontent.com/asokolsky/asokolsky.github.io/$REVIEWED_COMMIT/proxmox/lxc-from-oci.sh" \
  -o lxc-from-oci.sh
```

Use the latest commit that touched `proxmox/lxc-from-oci.sh` in the repository
history, after confirming it is the revision you trust. Review the downloaded
script before running it as root. Then install it:

```bash
install -m 0755 lxc-from-oci.sh /usr/local/sbin/
```

The subcommands are:

- `create CTID ...`: create and verify a new container.
- `check CTID`: compare its saved image fingerprint with the registry.
- `upgrade OLD_CTID NEW_CTID`: replace it when the image changes.
- `recover RECORD_DIR`: restore the old container from an upgrade record.

Use `lxc-from-oci.sh --help` or `lxc-from-oci.sh COMMAND --help` for usage.

## 1. Create a Container

Define the image reference once and pass the initial CT ID and network settings:

```bash
CTID=120
IMAGE_REF='docker.io/library/debian:latest'

lxc-from-oci.sh create "$CTID" "$IMAGE_REF" \
  --address 192.168.1.120/24 \
  --gateway 192.168.1.1
```

The script

- checks CT ID availability cluster-wide before pulling,
- downloads a uniquely named archive using the [Proxmox registry-pull API](https://pve.proxmox.com/pve-docs/api-viewer/index.html#/nodes/%7Bnode%7D/storage/%7Bstorage%7D/oci-registry-pull),
- captures the returned task ID, and waits for successful completion.

Before creating the container, it compares normalized
[`skopeo inspect --config`](https://github.com/containers/skopeo/blob/main/docs/skopeo-inspect.1.md)
output from the archive and registry. A mismatch stops creation. Check the selected
image and architecture, and retry in case the tag moved. If the mismatch persists
with a stable image, inspect both configurations before relying on fingerprint
comparisons for that image/tool version.

Immediately after the first successful creation, run `check "$CTID"` using the
status handling in Section 2. Expect status `0` while the tag is unchanged.
Creation already checked the archive against the registry; this additional
check verifies the saved Notes and detection path. Investigate status `10`
(the tag may have advanced) or any error before relying on future upgrades.

The default container has:

- One CPU core, 256 MiB memory, and a 2 GiB disposable root disk.
- A new `/srv/lxc-$CTID-data` directory, mounted read-only at `/mnt/example`.
  Creation refuses an existing directory and never overwrites its contents.
- A persistent `message.txt` file used by the verification command.
- Host-managed static networking on `vmbr0`.
- `/bin/sleep infinity` as its entrypoint.

The Debian OCI image normally starts `bash`; it does not provide a conventional
bootable system with systemd. The sleep process keeps this demonstration alive
for `pct exec`. For a conventional Debian system container, use a Proxmox Debian
template instead.

The script uses [`pct create`](https://pve.proxmox.com/pve-docs/pct.1.html#cli_pct_create),
then [`pct set --entrypoint`](https://pve.proxmox.com/pve-docs/pct.1.html#cli_pct_set):
OCI extraction can overwrite an entrypoint passed directly to `pct create`.
After starting the container, it verifies the persistent message and Debian
version information, saves metadata in Notes, and enables startup on boot.

Additional creation options include `--bridge`, `--root-storage`,
`--template-storage`, `--data-dir`, `--entrypoint`, `--verify-command`, and
`--stop-mode`. For another image, supply a suitable entrypoint and an application
verification command; the defaults assume Debian. The verification command runs
through `/bin/sh -ec` inside the container. On Debian, `/bin/sh` is `dash`;
use POSIX shell syntax rather than Bash-specific arrays, `[[ ... ]]`, or process
substitution in `--verify-command`.

## 2. Check for an Update

Run this on the same node used for installation:

```bash
lxc-from-oci.sh check "$CTID"
```

It reads the image reference and deployed fingerprint from Notes and inspects
only the registry image. It does not read or recalculate the deployed archive's
fingerprint. It trusts the saved fingerprint: hand-editing that Note can hide
an update or report an update that is not needed.

Exit status is `0` for unchanged, `10` for an available update, and any other
nonzero value for an error. Status `10` means you should choose an unused
replacement CT ID and run `upgrade` as shown in the next section. This example
also works with `set -e` and reports errors without exiting an interactive shell:

```bash
lxc-from-oci.sh check "$CTID" && rc=0 || rc=$?
case $rc in
  0) printf '%s\n' 'No upgrade needed.' ;;
  10) printf 'Run: lxc-from-oci.sh upgrade %s NEW_CTID\n' "$CTID" ;;
  *) printf 'Update check failed (status %s); resolve the error before upgrading.\n' "$rc" >&2 ;;
esac
```

The fingerprint includes configuration and filesystem layer content hashes for
the node's architecture. Updating only another architecture in a multi-platform
index does not trigger an upgrade. This fingerprint differs from the registry
manifest digest.

Notes contain `CURRENT_IMAGE=`, `DEPLOYED_FINGERPRINT=`, `OCI_SETTINGS=`,
and `OCI_BASE_CONFIG=` records. The script preserves other notes. Keep the
reserved records intact: they allow later invocations to work without variables
or functions from the installation shell. Inspect them, including the stored
fingerprint, with:

```bash
pct config "$CTID"
```

### Older Manual Installations

Containers made with older manual versions of this procedure lack the full
metadata required by this script.
There is no metadata-import or automated migration command. Recreate with
`create`, a new CT ID, a new data directory, and an application-specific
backup/restore plan. Stop the old container before reusing its IP address.
Retain it for rollback until the new one is verified; do not invent missing
metadata from the current mutable tag.

## 3. Upgrade

Choose another unused CT ID:

```bash
NEW_CTID=121
lxc-from-oci.sh upgrade "$CTID" "$NEW_CTID"
```

The script starts with the fingerprint check. If unchanged, it exits successfully
without creating a replacement. Otherwise it:

1. Checks the new ID cluster-wide and requires the old container to be running.
1. Compares its current configuration with the snapshot saved at creation.
   Configuration changes require manual review; the script refuses to silently
   discard settings it cannot reproduce.
1. Saves the old configuration, archive, persistent directory, and both CT IDs
   in a recovery directory under `/var/lib/lxc-from-oci`.
1. Updates the old container's Notes to identify the saved archive copy.
1. Pulls and verifies the new image, checking that it still matches the image
   detected at the start.
1. Creates the replacement with the stored settings and automatic startup disabled.
1. Stops the old container, starts the replacement, and runs verification.
1. Records the replacement's fingerprint and transfers the old boot setting to it.

Only one container may run with the service address at a time, so expect downtime
during cutover. The persistent data path remains the original installation's
path even though the replacement has a different CT ID.

The default `--stop-mode stop` uses [`pct stop`](https://pve.proxmox.com/pve-docs/pct.1.html#cli_pct_stop),
which is a hard stop suitable for this sleep/read-only-data demonstration.
For a real service, supply a working init/entrypoint, an application-specific
verification command, and `--stop-mode shutdown` when creating it.
That mode uses [`pct shutdown`](https://pve.proxmox.com/pve-docs/pct.1.html#cli_pct_shutdown)
with a timeout and no forced-stop fallback. If shutdown times out, inspect both
CT states using the recovery record below and fix graceful shutdown before
retrying. If the replacement remains running, keep the old container stopped.
Any manual hard stop requires you to account for pending application writes;
then follow the recovery commands below.

If startup or verification fails after cutover begins, the script attempts to
disable and stop the replacement before restoring and verifying the old
container. If it cannot confirm the replacement is stopped, it leaves the old
container stopped to avoid a duplicate IP address and reports the recovery record.

No container, data directory, or archive is automatically deleted. Failed
preparations leave the original container running and retain any partial
replacement for inspection. Remove retired resources separately after verifying
the successful deployment and your recovery requirements.

After success, update your shell variable: the script cannot change it in the
parent shell. Otherwise `check "$CTID"` still reads the old container's Notes:

```bash
CTID=$NEW_CTID
```

A mutable Debian tag can advance to another Debian release. Packages and files
changed inside the old root filesystem are not carried forward. Put repeatable
customizations in a derived image; keep persistent data in explicit mounts.

## 4. Roll Back and Recover

Use `recover` when a node outage, an uncatchable signal such as `SIGKILL`, or an
incomplete automatic recovery leaves the service unavailable. It also works as a
manual rollback after a successful upgrade, for example when the replacement
misbehaves a day later. Locate the printed record:

```bash
ls -d "${OCI_STATE_DIR:-/var/lib/lxc-from-oci}"/upgrade-*
```

Review `upgrade.json` before acting. It records the node, both CT IDs, the old
boot setting, the stop mode, and the verification command. The directory also
contains `old-config.json`, `old-image.tar`, and `data.tar.gz`.

On the recorded node, select that directory and inspect its record:

```bash
RECORD_DIR="${OCI_STATE_DIR:-/var/lib/lxc-from-oci}/upgrade-120-XXXXXXXX"
jq . "$RECORD_DIR/upgrade.json"
```

After reviewing the record, run:

```bash
lxc-from-oci.sh recover "$RECORD_DIR"
```

Recovery acquires the same CT locks as upgrade and uses the same stop and
verification logic as automatic rollback. It does not read the containers' Notes,
so damaged Notes cannot block it. It checks cluster inventory before touching
the replacement: an absent CT is allowed, while API errors or an ID belonging to
another node/guest type stop recovery.

If present, the replacement's automatic startup is disabled and it is stopped
with the recorded stop mode. The old container is started only after the
replacement is confirmed stopped or absent. After verifying the old application,
recovery restores its recorded boot flag. No registry access is needed.

If the replacement cannot shut down, recovery stops before starting the old CT.
Resolve its shutdown problem before retrying; do not run both at the same
address. There is no forced-stop fallback in shutdown mode.

If old-container verification fails, recovery reports its current state without
stopping it or restoring its boot flag. The replacement is stopped or absent,
and the old boot flag retains its pre-recovery value (often `0` after a completed
upgrade). Inspect it with `pct config`, correct
the application problem, and rerun `recover`. The old container's Notes retain
its saved archive and fingerprint throughout.

After a successful recovery, manage the old container again:

```bash
CTID=$OLD_CTID
```

The replacement is left stopped and unchanged. Its Notes still describe the new
image, so do not run `check` against it. Remove it separately once you no longer
need it for diagnosis.

The demonstrated data is read-only inside both containers. Applications with
writable data or database migrations need an application-consistent backup and
a compatible data-restore plan. Proxmox container backups do not include
[bind-mounted directory contents](https://pve.proxmox.com/pve-docs/chapter-pct.html#_bind_mount_points).

## Timeouts and Concurrent Runs

Creation, upgrade, and recovery acquire nonblocking locks for their CT IDs.
Another run using either ID fails rather than operating concurrently.

The script bounds individual CLI calls and task/verification polling. You can
set these environment variables:

- `OCI_COMMAND_TIMEOUT`: individual command limit, default 120 seconds.
- `OCI_TASK_TIMEOUT`: image-pull request and polling limit, default 600 seconds.
- `OCI_VERIFY_TIMEOUT`: verification retry window, default 60 seconds.
- `OCI_STATE_DIR`: locks and recovery records, default `/var/lib/lxc-from-oci`.
  Use the same directory for every invocation on a node.

A pull timeout does not cancel a Proxmox download worker. The CLI can run the
worker synchronously, mixing progress with its JSON result; the script extracts
the task ID from that output. If the request times out before returning an ID,
find the task by its printed archive filename in the node's task list. Inspect
the task ID with [`pvenode task status`](https://pve.proxmox.com/pve-docs/pvenode.1.html#cli_pvenode_task_status)
and [`pvenode task log`](https://pve.proxmox.com/pve-docs/pvenode.1.html#cli_pvenode_task_log)
before retrying.

## Local Validation

The script has no automated behavioral tests. From the repo root, these static
checks do not contact a registry or change containers:

```bash
bash -n proxmox/lxc-from-oci.sh
shellcheck proxmox/lxc-from-oci.sh
```

### Live Smoke Test

On 2026-11-19, the script was exercised on Proxmox VE 9.2.31 with `skopeo`
1.18.0 and `debian:latest` (Debian 13.7, amd64):

- The native OCI pull completed, and archive/registry fingerprints matched.
- An unprivileged CT was created and started with the persistent directory
  mounted read-only; its Debian information and test file were verified.
- `check` returned `0` using the fingerprint saved in Notes.
- The CT was stopped and destroyed, and its disk, data directory, downloaded
  archive, and temporary files were removed.

The test used a documentation-range address and `pct exec`; external networking
inside the container was not tested. Live upgrade, cutover, and recovery still
need validation.

## References

- [Proxmox VE 9.1 release notes](https://pve.proxmox.com/wiki/Roadmap#Proxmox_VE_9.1)
- [OCI images](https://pve.proxmox.com/pve-docs/chapter-pct.html#_open_container_initiative_oci_images)
- [Storage registry-pull API](https://pve.proxmox.com/pve-docs/api-viewer/index.html#/nodes/%7Bnode%7D/storage/%7Bstorage%7D/oci-registry-pull)
- [`pct` command reference](https://pve.proxmox.com/pve-docs/pct.1.html)
- [`pvesm` command reference](https://pve.proxmox.com/pve-docs/pvesm.1.html)
