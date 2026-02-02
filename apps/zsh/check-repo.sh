#!/bin/bash
#
# Script to check if any git repositories under a specified directory are dirty.
#
# Function to check if a git repository is dirty
is_repo_dirty() {
    # 'git status --porcelain' provides machine-readable output.
    # If there is any output, the repo is dirty.
    if [[ -n "$(git status --porcelain 2>/dev/null)" ]]; then
        return 0  # Repo is dirty
    else
        return 1  # Repo is clean
    fi
}
#
# The directory to check is the first argument provided to the script.
#
TARGET_DIR="${1:-.}" # Defaults to current directory if no argument is given

echo "Checking for git repositories under: $TARGET_DIR"
#
# Use a temporary status file to communicate between the subshell and the main script
#
STATUS_FILE=$(mktemp)
#
# Ensure the temporary file is deleted when the script exits, even on error
#
trap 'rm -f "$STATUS_FILE"' EXIT
#
# Write initial clean status (0) to the file
#
echo "0" > "$STATUS_FILE"

# Use 'find' to locate all .git directories recursively
# and then process their parent directories
find "$TARGET_DIR" -type d -name ".git" -print0 | while IFS= read -r -d '' gitdir; do
    # Get the parent directory of the .git directory (the repo root)
    repodir=$(dirname "$gitdir")
    # Move into the repository directory to run git commands
    pushd "$repodir" > /dev/null
    if is_repo_dirty; then
        echo "🔴 DIRTY: $repodir"
        # If a repo is dirty, update the temporary status file to 1
        echo "1" > "$STATUS_FILE"
    else
        echo "🟢 CLEAN: $repodir"
    fi
    # Return to the original directory before the next iteration
    popd > /dev/null
done

# Read the final status back from the file in the main shell context
FINAL_STATUS=$(cat "$STATUS_FILE")
#
# After checking all repositories, we finalize the exit status.
#
if [ "$FINAL_STATUS" -eq 1 ]; then
    echo "Summary: One or more dirty repositories were found. Exiting with status 1."
    exit 1
else
    echo "Summary: All repositories are clean. Exiting with status 0."
    exit 0
fi
