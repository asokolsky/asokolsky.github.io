# Home Assistant - Mount NAS Shares

[Source](https://community.home-assistant.io/t/nas-folders-on-home-assistant/393995)

Add this to home-assistant `configuration.yaml`:

```yaml
# Mount NAS drives
shell_command:
  mount_nas_music: mkdir -p /media/nas/music;mount -t cifs -o username=alex,password=xxx //192.168.x.x/music /media/nas/music
  mount_nas_movies: mkdir -p /media/nas/movies;mount -t cifs -o username=alex,password=xxx //192.168.x.x/movies /media/nas/movies
```

Note:

* use IPv4 address, not DNS name for NAS
* special chars in password are OK

Restart HA

Create Automation:

* Triggers: When Home Assistant is started
* Actions: Service: Shell command: mount_nas_music
* Actions: Service: Shell command: mount_nas_movies
