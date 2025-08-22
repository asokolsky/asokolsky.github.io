#!/usr/bin/env bash
# Exit on error. Append "|| true" if you expect an error.
set -o errexit
# Exit on error inside any functions or subshells.
set -o errtrace
# Do not allow use of undefined vars. Use ${VAR:-} to use an undefined VAR
set -o nounset
# Catch the error in case mysqldump fails (but gzip succeeds) in `mysqldump |gzip`
set -o pipefail
# Turn on traces, useful while debugging but commented out by default
set -o xtrace

# add your commands below...

#
# add repos
#

# Docker:
curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
echo "deb [signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "${VERSION_CODENAME}") stable" > "/etc/apt/sources.list.d/docker.list"

apt-get update -q && apt-get -yq --no-install-recommends install \
    audacity \
    bolt \
    cpufrequtils \
    dmidecode \
    emacs-nox \
    emacsPackages.dracula-theme \
    ethtool \
    ffmpeg \
    gh \
    git \
    glab \
    htop \
    lm-sensors \
    lsb-release \
    mkvtoolnix \
    mmv \
    nvme-cli \
    obs-studio \
    pciutils \
    powertop \
    pstree \
    python3 \
    python3-dev \
    python3-pip \
    python3-venv \
    rsync \
    smartmontools \
    solaar \
    sysstat \
    usbutils \
    v4l-utils \
    vim \
    vlc \
    vscode-with-extensions \
    wget \
    zoom-us \
    zsh
