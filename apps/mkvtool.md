# MKVTool

[repo](https://github.com/marcopaganini/mkvtool),
[man page](https://github.com/marcopaganini/mkvtool/blob/master/docs/mkvtool.1.md).

## Install

```
git clone https://github.com/marcopaganini/mkvtool
cd mkvtool
make
#make manpage # <-- optional
sudo make install
```

> mkvtool show ./S01E01.mkv
+--------+-----------+------+----------+---------------------+---------+
| NUMBER | TYPE      | NAME | LANGUAGE | CODEC               | DEFAULT |
+--------+-----------+------+----------+---------------------+---------+
|      0 | video     |      | eng      | AVC/H.264/MPEG-4p10 | <=====  |
|      1 | audio     |      | rus      | AC-3                | <=====  |
|      2 | audio     |      | eng      | AC-3                |         |
|      3 | subtitles |      | rus      | SubRip/SRT          |         |
|      4 | subtitles |      | eng      | SubRip/SRT          |         |
+--------+-----------+------+----------+---------------------+---------+
