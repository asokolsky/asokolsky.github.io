# MacOS Customization

MacOS:

* [Features, Tips and Tricks](https://apple.stackexchange.com/questions/400/please-share-your-hidden-macos-features-or-tips-and-tricks)
* [reset](reset.html)
* [startup key combinations](https://support.apple.com/en-us/102603)

## Disk

Repair disk using:

* [Disk Utility](https://support.apple.com/en-us/102611),
[Disk Utility User Guide](https://support.apple.com/guide/disk-utility/welcome/mac)
* [Stellar Data Recovery](https://www.stellarinfo.com/blog/repair-corrupt-mac-partition/)

Alternatively, using CLI:

* boot into a single-user mode: press and hold the Command+S keys while MacOS
boots.
* use
[diskutil and fsck](https://appleinsider.com/inside/macos/tips/how-to-use-fsck-to-check-and-repair-macos-disks)

## Optimizing input

* Differentiate touch pad and mouse scroll direction using
[scroll reverser](https://pilotmoon.com/scrollreverser/).
* use of [keyboard](keyboard.html)
* use of [keyboard in finder](finder.html)

## Running Apps on Mac

For any software development install
[Command Line Tools](https://developer.apple.com/library/archive/technotes/tn2339/):

```sh
xcode-select --install
```

Then:
* [homebrew](https://brew.sh/)
* cli: [exiftool](/apps/cli-exiftool.html), and [more...](cli.html)
* [iTerm2](iTerm2.html) Terminal Emulator
* [stats](https://github.com/exelban/stats)
* [Java](java.html)
* [Jenkins](jenkins.html)
* [docker](/apps/docker/docker-macos.html) and
[colima](/apps/docker/colima.html)
* [psql client](/apps/psql-client.html)

Also relevant:

* [dot-files](/apps/dot-files/)
* [emacs colors](/apps/emacs/)

## Terminal Peculiarities

```
> stty -a
speed 38400 baud; 48 rows; 125 columns;
lflags: icanon isig iexten echo echoe echok echoke -echonl echoctl
	-echoprt -altwerase -noflsh -tostop -flusho pendin -nokerninfo
	-extproc
iflags: -istrip icrnl -inlcr -igncr ixon -ixoff ixany imaxbel iutf8
	-ignbrk brkint -inpck -ignpar -parmrk
oflags: opost onlcr -oxtabs -onocr -onlret
cflags: cread cs8 -parenb -parodd hupcl -clocal -cstopb -crtscts -dsrflow
	-dtrflow -mdmbuf
cchars: discard = ^O; dsusp = ^Y; eof = ^D; eol = <undef>;
	eol2 = <undef>; erase = ^?; intr = ^C; kill = ^U; lnext = ^V;
	min = 1; quit = ^\; reprint = ^R; start = ^Q; status = ^T;
	stop = ^S; susp = ^Z; time = 0; werase = ^W;
```

The above
[interferes with AWS SM](https://github.com/aws/session-manager-plugin/issues/29).
Workaround:

```sh
# Allow for Ctrl+S, Ctrl+Y to be used in SSM
stty stop undef;stty dsusp undef
```
