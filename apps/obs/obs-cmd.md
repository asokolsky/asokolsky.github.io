# obs-cmd

[OBS-cmd](https://github.com/grigio/obs-cmd) is a command-line remote control
for OBS. It requires the
[obs-websocket](https://github.com/obsproject/obs-websocket) to be enabled.

## Installation

[Download obs-cmd](https://github.com/grigio/obs-cmd/releases/latest),
pick the correct binary, e.g. `obs-cmd-linux-amd64`.  Then
```sh
wget https://github.com/grigio/obs-cmd/releases/download/v0.17.9/obs-cmd-linux-amd64
chmod +x obs-cmd-linux-amd64
sudo mv obs-cmd-linux-amd64 /usr/local/bin/obs-cmd
```

## OBS Configuration

Select Tools / WebSocket Server Settings:

* Check Enable WebSocket server
* Save the Server Port - 4455 in my case
* Click Generate Password
* Click Show Connect Info and save it:

```sh
export OBSWS=obsws://127.0.0.1:4455/secret
```

## Using obs-cmd

```sh
obs-cmd -w $OBSWS info
```

To switch the scene:
```sh
obs-cmd -w $OBSWS scene switch "Scene Name"
```
