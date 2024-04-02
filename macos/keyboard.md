# Better Keyboard Support in MacOS

## Notation

Key|Symbol
---|------
Cmd/⊞ Win|⌘
Shift|⇧
Opt / Alt|⌥
Ctrl|⌃
Caps Lock|⇪
Fn|

## Pre-existing Accelerators

[Standard Mac keyboard
shortcuts](https://support.apple.com/en-us/HT201236), here are few:

Shortcut|Document Function
-------|-------
⌘ N|New
⌘ O|Open
⌘ P|Print
⌘ S|Save

Shortcut|Edit Function
-------|-------
⌘ Z|Undo
⌘ Shift-Z|Redo
⌘ X|Cut
⌘ C|Copy
⌘ V|Paste
⌘ A|Select All

Shortcut|Find Function
-------|-------
⌘ F|Find items in a document or open a Find window.
⌘ G|Find next
⌘ Shift-G|Find the previous

Shortcut|Window Function
-------|-------
⌘ H|Hide the windows of the front app
⌘ Opt-H|View the front app but hide all other apps
⌘ M|Minimize the front window to the Dock
⌘ Opt-M|Minimize all windows of the front app
⌘ T|Open a new tab
⌘ W|Close the front window
⌘ Opt-W|Close all windows of the app
⌘ ⌃ F|Full screen

Shortcut|Application Function
------- | -------
⌘ Q|Quit an app
⌘ Opt-Esc|Force quit an app

Shortcut|Application/Finder Function
------- | -------
⌘ Space|Show or hide the Spotlight search field
⌘ Opt-Space|Spotlight search from Finder
⌘ ⌃ Space|Show the Character Viewer, to pick emoji and other symbols
Space|Use Quick Look to preview the selected item
⌘ Tab|Switch to the next most recently used app among your open apps
⌘ Shift-3|Take a screenshot
⌘ Shift-4|Take a screenshot
⌘ Shift-5|Take a screenshot or make a screen recording
⌘ Shift-N|Create a new folder in the Finder
⌘ ,|Open preferences for the front app
⌘ Opt-D|Hide and unhide the Dock
⌃ ↑|Show Mission Control

To customize: [how to keep track of keyboard
shortcuts](https://www.macworld.com/article/217325/how-to-keep-track-of-keyboard-shortcuts.html)

## Custom System-wide Keyboard Accelerators - BAD IDEA

I experimented with system-wide accelerators for:

Shortcut|Function
------- | -------
⌃ Z|Undo
⌃ X|Cut
⌃ C|Copy
⌃ V|Paste

This proved to be a BAD idea.  Instead of defining accelerators in
multiple places, do it in karabiner only - see below.

## Proper Keyboard Support

Differentiate Let/Right Ctrl, Swap Ctrl and CapsLock, support for Home/End, etc:

* [karabiner-elements](https://karabiner-elements.pqrs.org/) with
* [karabiner-windows-mode](https://github.com/rux616/karabiner-windows-mode)

## Tile Windows using Keyboard only

Use:

* [spectacle](https://www.spectacleapp),
[sources](https://github.com/eczarny/spectacle)
* or better yet [Rectangle](https://github.com/rxhanson/Rectangle)

## Terminal Emulator

I use [iTerm2](iTerm2.html).

## Repurpose the Existing Keyboard Accelerators

Ctrl+Left/Right are mapped to desktop switching in macOS by default.
I prefer to make these available to apps, so I need to remove the default
bindings.
Goto System Preferences / Keyboard / Shortcuts / Mission control,
remove Ctrl+Left/Right