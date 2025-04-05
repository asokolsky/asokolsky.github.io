# gron

gron makes JSON greppable!

Works with [jq](cli-jq.html).

## Installation

MacOS:
```sh
brew install gron
```

Linux:
```sh
sudo apt install gron
```

## Use

Example: what is the path to use with `jq` to isolate name of the bridge in the output of
```sh
docker network inspect bridge
```
Pipe it through `gron` and then use `grep`
```
> docker network inspect bridge|gron|grep name
json[0].Options["com.docker.network.bridge.name"] = "docker0";
```
and then use the path with `jq`:

```
> docker network inspect bridge|jq '.[0].Options["com.docker.network.bridge.name"]'
"docker0"
```
