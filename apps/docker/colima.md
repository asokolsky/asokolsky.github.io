# Colima - Docker Desktop Alternative

[Colima](https://github.com/abiosoft/colima) stands for Containers in
[Lima](https://github.com/lima-vm/lima), which, in turn, stands for Linux on Mac.
Hence Containers in Linux on Mac.  Colima replaces Docker Engine. Once Colima is
installed and configured, you can interact with it using a regular docker
client.

Advantages:

* faster than Docker Desktop
* supports cross-architecture builds

(Dis)Advantage:

* Colima is CLI-only, no GUI

If you need a GUI - look at Podman Desktop

## Installation

```sh
brew install colima
```
Also:
```sh
brew install docker docker-compose docker-buildx
```
Do NOT install `docker` via `brew` with the `--cask` switch. That will install
Docker Desktop instead of CLI.

add CLI plugins:
```sh
mkdir -p ~/.docker/cli-plugins
ln -sfn /opt/homebrew/opt/docker-compose/bin/docker-compose ~/.docker/cli-plugins/docker-compose
ln -sfn /opt/homebrew/opt/docker-buildx/bin/docker-buildx ~/.docker/cli-plugins/docker-buildx
```

To verify:
```sh
docker compose version
docker buildx version
```

## Use

```sh
colima start --cpu 4 --memory 8
```
If an app reports
`Cannot connect to the Docker daemon at unix:///var/run/docker.sock. Is the docker daemon running?`
to resolve:
```sh
export DOCKER_HOST=unix://$HOME/.colima/docker.sock
```

To edit default config:
```sh
colima template --editor emacs
```

## Troubleshooting the Colima VM

To look at the VM state and the resources allocated:
```sh
colima ls
```

Under the hood, Colima runs an Ubuntu VM which may need to be recycled.

To update and reboot the VM:
```
$ colima ssh
user@colima:~$ sudo apt update -y && sudo apt upgrade -y
user@colima:~$ reboot
```

A more brute-force approach is to delete the VM and provision a new one.

```sh
colima delete -f
colima start -v --cpu 4 --memory 8
```

Note the `-v` switch which will produce additional output that can be helpful.
