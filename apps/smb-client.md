# smb client

## List shares

```
% sudo smbclient -U nass/alex -L nass.lan
Password for [NASS\alex]:

	Sharename       Type      Comment
	---------       ----      -------
	IPC$            IPC       IPC Service (TrueNAS Server)
	downloads       Disk
	music           Disk
	movies          Disk
	homes           Disk
	alex            Disk      Home directory of alex
```

## Establish a session and execute commands

```
% sudo smbclient -U nass/alex '\\nass.lan\movies'
Password for [NASS\alex]:
Try "help" to get a list of possible commands.
smb: \> pwd
Current directory is \\nass.lan\movies\
smb: \> cd K\
smb: \K\>
smb: \K\> ls
  .                                   D        0  Sun Jun  3 20:13:22 2018
  ..                                  D        0  Wed Mar  2 19:31:08 2022
  file.mkv                            A 8490612756  Thu Mar 26 01:18:25 2015
smb: \K\> get file.mkv
getting file \K\file.mkv of size 8490612756 as file.mkv (114027.4 KiloBytes/sec) (average 114027.4 KiloBytes/sec)
```
