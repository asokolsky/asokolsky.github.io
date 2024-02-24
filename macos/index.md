# MacOS Customization

For software development you will need
[Command Line Tools](https://developer.apple.com/library/archive/technotes/tn2339/):

```sh
xcode-select --install
```

## Optimizing input

* Differentiate touch pad and mouse scroll direction using
[scroll reverser](https://pilotmoon.com/scrollreverser/).
* use of [keyboard](keyboard.html)
* use of [keyboard in finder](finder.html)

## Apps to Use

* cli: [exiftool](/apps/cli-exiftool.html), and [more...](cli.html)
* [iTerm2](iTerm2.html) Terminal Emulator
* [Java](java.html)
* [Jenkins](jenkins.html)

Also relevant:

* [dot-files](/apps/dot-files/)
* [emacs colors](/apps/emacs/)

[MacOS Features, Tips and Tricks](https://apple.stackexchange.com/questions/400/please-share-your-hidden-macos-features-or-tips-and-tricks)

[MacOS reset](reset.html)

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

The above [interfering with SSM](https://github.com/aws/session-manager-plugin/issues/29)

Workaround:

```sh
# Allow for Ctrl+S, Ctrl+Y to be used in SSM
stty stop undef;stty dsusp undef
```
