# Better Keyboard Support in MacOS

## Pre-existing Accelerators

* Command-Option-D - Hide and unhide the Dock
* Command-Space - activate Spotlight’s menu bar drop-down
* Shift-Command-3 - take a screenshot
* Control-Up Arrow - show Mission Control

To customize: [how to keep track of keyboard
shortcuts](https://www.macworld.com/article/217325/how-to-keep-track-of-keyboard-shortcuts.html)

## Custom System-wide Keyboard Accelerators - BAD IDEA

I experimented with system-wide accelerators for:

* Undo - Ctrl+Z
* Cut - Ctrl+X
* Copy - Ctrl+C
* Paste - Ctrl+V

This proved to be a BAD idea.  Instead of defining accelerators in multiple
places, do it in karabiner only - see below.

## Proper Keyboard Support

Differentiate Let/Right Ctrl, Swap Ctrl and CapsLock, support for Home/End, etc:

* [karabiner-elements](https://karabiner-elements.pqrs.org/) +
* [karabiner-windows-mode](https://github.com/rux616/karabiner-windows-mode)

## Tile Windows using Keyboard only

Use:

* [spectacle](https://www.spectacleapp), [sources](https://github.com/eczarny/spectacle)
* or better yet [Rectangle](https://github.com/rxhanson/Rectangle)