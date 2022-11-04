# Customize Visual Studio Code

## Font

I really like [Source Code Pro](fonts.html) by Adobe.

## User Settings

Depending on the platform, the [user
settings](https://code.visualstudio.com/docs/getstarted/settings)
are stored in `settings.json` in the following directory:

OS|Path
--|---
Windows | `%APPDATA%\Code\User\`, where `%APPDATA%` is usually `C:\Users\_username_\AppData\Roaming`
macOS | `/Users/_username_/Library/Application Support/Code/User/`
Linux | `~/.config/Code/User/`

### settings.json

```json
{
    "editor.fontFamily": "'Source Code Pro',Consolas,monospace",
    "editor.fontLigatures": true,
    "editor.rulers": [80],
    "files.trimFinalNewlines": true,
    "files.trimTrailingWhitespace": true,
    "git.autofetch": true,
    "git.confirmSync": false,
    "git.enableSmartCommit": true,
    "security.workspace.trust.untrustedFiles": "newWindow",
    "terminal.integrated.scrollback": 10000,
    "workbench.editorAssociations": {
        "*.ipynb": "jupyter.notebook.ipynb"
    },
}
```

On Windows I also have:
```json
    "terminal.integrated.profiles.windows": {
        "PowerShell": {
            "source": "PowerShell",
            "icon": "terminal-powershell"
        },
        "Command Prompt": {
            "path": [
                "${env:windir}\\Sysnative\\cmd.exe",
                "${env:windir}\\System32\\cmd.exe"
            ],
            "args": [],
            "icon": "terminal-cmd"
        },
        "Ubuntu-22.04 (WSL)": {
            "path": "C:\\WINDOWS\\System32\\wsl.exe",
            "args": [
                "-d",
                "Ubuntu-22.04"
            ]
        }
    },
    "terminal.integrated.defaultProfile.windows": "Ubuntu-22.04 (WSL)",
```

### keybindings.json

On Windows:

```json
// Place your key bindings in this file to override the defaults
[
    {
        "key": "ctrl+d",
        "command": "-editor.action.addSelectionToNextFindMatch",
        "when": "editorFocus"
    },
    {
        "key": "ctrl+d",
        "command": "deleteRight",
        "when": "editorFocus"
    }
]
```

On MacOS:

```json
[
    { "key": "ctrl+z",       "command": "undo" },
    { "key": "ctrl+a",       "command": "editor.action.selectAll" },
    { "key": "ctrl+c",       "command": "execCopy" },
    { "key": "ctrl+x",       "command": "execCut" },
    { "key": "ctrl+v",       "command": "execPaste" },
    { "key": "alt+ctrl+s",   "command": "saveAll" },
    { "key": "ctrl+s",       "command": "workbench.action.files.save" },
    { "key": "shift+ctrl+s", "command": "workbench.action.files.saveAs" },
    { "key": "shift+ctrl+s", "command": "workbench.action.files.saveLocalFile",
      "when": "remoteFileDialogVisible" },
    { "key": "ctrl+f",
      "command": "actions.find",
      "when": "editorFocus || editorIsOpen"
    },
]
```

## Workspace Settings - Python

Python workspace `.vscode/settings.json`:

```json
{
    "python.linting.enabled": true,
    "python.linting.flake8Enabled": true,
    "python.linting.mypyEnabled": true,
    "python.linting.mypyArgs": [
        "--ignore-missing-imports",
        "--follow-imports=silent",
        "--show-column-numbers",
        "--strict"
    ],
    "python.linting.pylintEnabled": false,
    "python.linting.pylintUseMinimalCheckers": false,
    "python.testing.pytestEnabled": false,
    "python.testing.unittestEnabled": true,
    "python.testing.unittestArgs": [
        "-v", "-s", "./src", "-p", "*_test.py"
    ],
}
```

You can tell I like unittest and `mypy`, not `pylint` and `pytest`.

Oh and `.flake8` is:

```
[flake8]
extend-ignore = E127,E128,E231,E265,E302,E501
exclude = doc,.git,.mypy_cache,__pycache__,.vscode
max-complexity = 20
```


## Keyboard Bindings

[vscode-keys](vscode-keys.html)
