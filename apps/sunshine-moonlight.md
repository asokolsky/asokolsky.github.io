# Sunshine + Moonlight

## Sunshine

[repo](https://github.com/LizardByte/Sunshine/),
[docs](https://docs.lizardbyte.dev/projects/sunshine/latest/).

### MacOS install

Use [homebrew](https://github.com/LizardByte/homebrew-homebrew):
```sh
brew tap LizardByte/homebrew
brew install sunshine

```

### Linux install

```sh
flatpak install flathub dev.lizardbyte.app.Sunshine
```

### Use

Just run it:
```sh
sunshine
```
In the produced output:
```
Configuration UI available at [https://localhost:47990]
```

## Moonlight

https://moonlight-stream.org/

### MacOS install

```sh
brew install --cask moonlight
```

PC client

### Keyboard Shortcuts

PC

Shortcut|Description
--------|-----------
Ctrl-Alt-Shift-Q|Quit the streaming session (leaving the game running on the host PC)
Ctrl-Alt-Shift-Z|Toggle mouse and keyboard capture
Ctrl-Alt-Shift-X|Toggle between full-screen and windowed mode
Ctrl-Alt-Shift-S|Open performance stats overlay (not supported on Steam Link or Raspberry Pi)
Ctrl-Alt-Shift-M|Toggle mouse mode (pointer capture or direct control)
Ctrl-Alt-Shift-V|Type clipboard text on the host
Ctrl-Alt-Shift-D|Minimize the stream window
Ctrl-Alt-Shift-C|Toggle local cursor display in remote desktop mouse mode (remote cursor will always show up due to GameStream limitations)
Ctrl-Alt-Shift-L|Toggle locking the mouse pointer to the video area (requires "Optimize mouse for remote desktop instead of games" checkbox enabled)

MacOS

Shortcut|Description
--------|-----------
Command+Option+Shift+Q|quits the streaming session,
Command+Option+Shift+Z|toggles mouse and keyboard capture,
Command+Option+Shift+X|toggles full-screen/windowed mode,
Command+Option+Shift+S|displays performance statistics.

Alt key on a Mac is the Option (⌥) key.

The Command (⌘) key is used in place of the Windows key (⊞) on macOS.

If you're having trouble with the shortcuts, ensure "Capture system keyboard shortcuts" is enabled in Moonlight's settings
