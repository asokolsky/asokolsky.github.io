# smbclient

[man page](https://linux.die.net/man/1/smbclient)

## List shares

```
> smbclient -L nass
Password for [WORKGROUP\alex]:

        Sharename       Type      Comment
        ---------       ----      -------
        IPC$            IPC       IPC Service (TrueNAS Server)
        homes           Disk
        movies          Disk
        downloads       Disk
        music           Disk
        alex            Disk      Home directory of alex
SMB1 disabled -- no workgroup available
```

## Interactive Shell

### Listing Content

```
> smbclient //nass/movies
Password for [WORKGROUP\alex]:
Try "help" to get a list of possible commands.
smb: \> ls
  .                                   D        0  Thu Mar 28 17:44:08 2024
  ..                                  D        0  Sat Dec 30 12:21:25 2023
  I                                   D        0  Wed Jan 24 18:47:45 2024
  C                                   D        0  Wed Feb 21 19:10:40 2024
  W                                   D        0  Mon Oct 30 17:51:06 2023
  _TVShows                            D        0  Sun Mar 10 22:42:11 2024
  0123456789                          D        0  Thu Aug 10 17:20:22 2023
  .recycle                           DH        0  Thu Dec 16 14:31:22 2021
  .DS_Store                          AH    10244  Thu Mar 28 17:44:43 2024
  P                                   D        0  Wed Mar 13 20:01:32 2024
  Z                                   D        0  Tue Dec  1 16:17:24 2020
  N                                   D        0  Wed Jan 24 18:44:37 2024
  D                                   D        0  Fri Aug 18 11:50:26 2023
  T                                   D        0  Wed Aug 16 15:16:50 2023
  J                                   D        0  Sun Jul  9 10:40:00 2023
  G                                   D        0  Thu Feb  1 18:42:12 2024
  M                                   D        0  Thu Jan 25 09:18:54 2024
  Y                                   D        0  Fri Jul  7 12:35:14 2023
  S                                   D        0  Mon Oct 30 17:49:57 2023
  Q                                   D        0  Wed Nov 11 15:49:45 2020
  E                                   D        0  Tue Aug 15 11:41:35 2023
  O                                   D        0  Wed Feb 21 19:12:10 2024
  B                                   D        0  Tue Feb 27 08:00:33 2024
  H                                   D        0  Sun Jul  9 10:40:41 2023
  V                                   D        0  Wed Feb 21 19:00:56 2024
  L                                   D        0  Thu Jan 25 09:14:15 2024
  F                                   D        0  Thu Jul  6 12:26:09 2023
  R                                   D        0  Sun Aug 13 17:33:10 2023
  X                                   D        0  Wed Nov 11 15:48:08 2020
  U                                   D        0  Thu Jan 25 09:21:15 2024
  K                                   D        0  Wed Mar  2 19:31:08 2022
  A                                   D        0  Sat Jul  8 10:08:43 2023

                14204235776 blocks of size 1024. 5500541824 blocks available
```

```
smb: \> all info _TVShows
NT_STATUS_OBJECT_NAME_NOT_FOUND getting alt name for \info
smb: \> allinfo _TVShows
altname: _TVShows
create_time:    Mon Nov 30 01:18:49 PM 2020 PST
access_time:    Mon Nov 30 01:18:49 PM 2020 PST
write_time:     Sun Mar 10 10:42:11 PM 2024 PDT
change_time:    Sun Mar 10 10:42:11 PM 2024 PDT
attributes: D (10)
@GMT-2023.02.28-02.42.50
create_time:    Mon Nov 30 01:18:49 PM 2020 PST
access_time:    Mon Nov 30 01:18:49 PM 2020 PST
write_time:     Sun Nov 13 02:22:25 PM 2022 PST
change_time:    Sun Nov 13 02:22:25 PM 2022 PST
size: 0
```
