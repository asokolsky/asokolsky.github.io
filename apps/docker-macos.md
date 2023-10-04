# Using Docker on MacOS

Docker desktop is bad choice.  Use [Colima](https://github.com/abiosoft/colima)
(containers in [Lima](https://github.com/lima-vm/lima)) instead.

## Install Colima

```sh
brew install colima
```

If you observe
“Cannot connect to the Docker daemon at unix:///var/run/docker.sock. Is the docker daemon running?”
set `DOCKER_HOST`:
```sh
export DOCKER_HOST=unix://$HOME/.colima/docker.sock
```

## Install Docker and Docker Compose
