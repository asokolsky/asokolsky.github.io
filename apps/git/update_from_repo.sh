#!/bin/bash
#
# This will update DST with the latest version of SRC from REPO.
DST=discard_me.cpp
SRC=trash1.cpp
REPO_HOST="git@github.com:asokolsky"
REPO=oddeven
#
# Exit on error. Append "|| true" if you expect an error.
set -o errexit
# Exit on error inside any functions or subshells.
set -o errtrace
# Do not allow use of undefined vars. Use ${VAR:-} to use an undefined VAR
set -o nounset
# Catch the error in case mysqldump fails (but gzip succeeds) in `mysqldump |gzip`
set -o pipefail
# Turn on traces, useful while debugging but commented out by default
#set -o xtrace
# Check syntax with `shellcheck ./goto`

# this repo root
DSTROOT=$(git rev-parse --show-toplevel)
# this one already defined in MacOS
: "${TMPDIR:=/tmp}"

pushd "${TMPDIR}" > /dev/null
echo "Retrieving ${REPO}/${SRC}"
git clone --quiet --no-checkout --depth 1 "${REPO_HOST}/${REPO}.git"
cd $REPO
echo "Overwriting ${DSTROOT}/${DST}"
git show HEAD:$SRC > "${DSTROOT}/${DST}"
popd > /dev/null
rm -rf "${TMPDIR}/${REPO}"
