# MacOS Customization

For software development you will need
[Command Line Tools](https://developer.apple.com/library/archive/technotes/tn2339/_index.html):

```sh
xcode-select --install
```

## Optimizing input

* Differentiate touch pad and mouse scroll direction using
[scroll reverser](https://pilotmoon.com/scrollreverser/).
* use of [keyboard](keyboard.html)

## Apps to Use

* cli: [exiftool](../apps/cli-exiftool.html), and [more...](cli.html)
* [iTerm2](iTerm2.html) Terminal Emulator
* [Java](java.html)
* [Jenkins](jenkins.html)

Also relevant:

* [dot-files](../apps/dot-files/)
* [emacs colors](../apps/emacs.html)

[hidden-macos-features-or-tips-and-tricks](https://apple.stackexchange.com/questions/400/please-share-your-hidden-macos-features-or-tips-and-tricks)

## Finder

### Ensure dot files are displayed

Keyboard shortcut: `Shift` + `Command` + `.`

cli:
```sh
defaults write com.apple.finder AppleShowAllFiles YES
```

### Show file extensions

Finder/Settings/Advanced - Show all filename extensions - CHECK
