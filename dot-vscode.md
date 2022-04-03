# Customize Visual Studio Code

## Font

I really like [Source Code Pro](fonts.html) by Adobe.

## User Settings

Depending on the platform, the [user
settings](https://code.visualstudio.com/docs/getstarted/settings)
are stored in `settings.json` in the folloing directory:

* Windows:  `%APPDATA%\Code\User\`
* macOS: `/Users/{username}/Library/Application Support/Code/User/`
* Linux: `$HOME/.config/Code/User/`

### settings.json

```json
{
    "editor.fontFamily": "'Source Code Pro',Consolas",
    "editor.fontLigatures": true,
    "editor.rulers": [80],
    "files.trimFinalNewlines": true,
    "files.trimTrailingWhitespace": true,
    "git.autofetch": true,
    "git.confirmSync": false,
    "security.workspace.trust.untrustedFiles": "newWindow",
    "workbench.editorAssociations": {
        "*.ipynb": "jupyter.notebook.ipynb"
    },
}
```

### keybindings.json

On Windows:

```json
// Place your key bindings in this file to override the defaultsauto[]
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
    "python.linting.flake8Enabled": false,
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
    "python.testing.unittestArgs": [
        "-v", "-s", "./src", "-p", "*_test.py"
    ],
    "python.testing.unittestEnabled": true
}
```

You can tell I like unittest and mypy, not pylint and pytest.
