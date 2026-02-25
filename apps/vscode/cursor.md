# Setting Up Cursor

Being a fork of vscode, it is easy to [migrate](https://cursor.com/docs/configuration/migrations/vscode) your settings to cursor.

## User Settings

Depending on the platform, the user settings are stored in `settings.json` in the following directory:

OS|Path
--|---
Windows|`%APPDATA%\Cursor\User\`, where `%APPDATA%` is usually `C:\Users\_username_\AppData\Roaming`
MacOS|`/Users/_username_/Library/Application Support/Cursor/User/`
Linux|`~/.config/Cursor/User/`

NOTE: the above is different from cursor CLI with settings in `~/.cursor`

## Extensions

You can [migrate](https://cursor.com/docs/configuration/migrations/vscode) your vscode extensions to cursor.
