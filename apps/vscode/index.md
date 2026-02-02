# Setting Up Visual Studio Code

- [Setting Up Visual Studio Code](#setting-up-visual-studio-code)
  - [Quick Tips](#quick-tips)
  - [Font](#font)
  - [User Settings](#user-settings)
    - [settings.json](#settingsjson)
    - [keybindings.json](#keybindingsjson)
  - [Standard Keyboard Bindings](#standard-keyboard-bindings)
  - [Command Palette](#command-palette)
  - [Extensions](#extensions)
  - [Using](#using)


## Quick Tips

[25 VS Code Productivity Tips and Speed Hacks](https://www.youtube.com/watch?v=ifTF3ags0XI)

## Font

I really like [Source Code Pro](../fonts.html) by Adobe.

## User Settings

Depending on the platform, the [user settings](https://code.visualstudio.com/docs/getstarted/settings) are stored in `settings.json` in the following directory:

OS|Path
--|---
Windows|`%APPDATA%\Code\User\`, where `%APPDATA%` is usually `C:\Users\_username_\AppData\Roaming`
MacOS|`/Users/_username_/Library/Application Support/Code/User/`
Linux|`~/.config/Code/User/`

### settings.json

```json
{% include_relative settings.json %}
```
On Windows I also have:
```json
{% include_relative settings-windows.json %}
```

### keybindings.json

On Windows:

```json
{% include_relative keybindings-windows.json %}
```

On MacOS:

```json
{% include_relative keybindings-macos.json %}
```
## Standard Keyboard Bindings

* [Linux](keys-linux.html)
* [MacOS](keys-mac.html)
* [Windows](keys-windows.html)

## Command Palette

Char|Accelerator|Description
----|-----------|-----------
&nbsp;|`Ctrl+P`|Navigate to a file or symbol by name
`>`|`Ctrl+Shift+P`|Show and run commands
`@`|`Ctrl+Shift+O`|Navigate to a specific symbol in a file
`:`|`Ctrl+G`|Goto a line in a file
`?`|n/a|Get help

## Extensions

* [Code spell checker](https://github.com/streetsidesoftware/vscode-spell-checker)
* [Excalidraw](https://github.com/excalidraw/excalidraw-vscode)
* [Markdown All in One](https://marketplace.visualstudio.com/items?itemName=yzhang.markdown-all-in-one), [source](https://github.com/yzhang-gh/vscode-markdown)

## Using

[VSCode Variables Reference](https://code.visualstudio.com/docs/editor/variables-reference)

* [vscode for python](python.html)
* [vscode for C/C++](c_c++.html)
