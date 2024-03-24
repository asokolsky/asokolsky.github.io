# Docker Desktop

## Check if installed

```sh
docker version -f "{{.Server.Platform.Name}}"
```
If this says `Docker Desktop` instead of `Docker Engine - Community` - you are
using Docker Desktop.

## Alternatives

* [colima](colima.html)
* [podman desktop](podman-desktop.html)

## Uninstall

Remove any `"credsStore": …` key from  `~/.docker/config.json`.

If there is a "context" line, run `docker context use default`.

Then proceed with uninstall as usual.
