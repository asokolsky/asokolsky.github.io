# Docker Cheat Sheet

## List images

```sh
docker image ls
```

## List containers

List running:

```sh
docker container ls
```

List all containers, not only running, do not truncate output:

```sh
docker container ls -a --no-trunc
```

List IDs only:

```
docker container ls -q
1addfea727b3
09c4105cb356
443fc0c41710
b06cfe3053e5
4cf774b9e4a4
```
## Kill all containers

Force delete all containers:

```sh
docker container rm -f $(docker container ls -aq)
```

## Inspect container

Inspecting container produces JSON:

```sh
sudo docker inspect _container_id_
```

Extract container environment and sort it.
```
sudo docker inspect _container_id_ | jq ".[0].Config.Env|sort[]"
```
