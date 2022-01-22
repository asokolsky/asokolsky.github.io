# Visual Studio Code Settings

Depending on the platform, the user `settings.json` is in:

* Windows:  `%APPDATA%\Code\User\`
* macOS: `/Users/{username}/Library/Application Support/Code/User/`
* Linux `$HOME/.config/Code/User/`

My `setings.json`:

```
{
    "editor.rulers": [80],
    "editor.wordWrap": "wordWrapColumn",
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

On macOS I also have `keybindings.json`:

```
[
    { "key": "ctrl+z",                "command": "undo" },
    { "key": "ctrl+a",                "command": "editor.action.selectAll" },
    { "key": "ctrl+c",                "command": "execCopy" },
    { "key": "ctrl+x",                "command": "execCut" },
    { "key": "ctrl+v",                "command": "execPaste" },
    { "key": "alt+ctrl+s",            "command": "saveAll" },
    { "key": "ctrl+s",                "command": "workbench.action.files.save" },
    { "key": "shift+ctrl+s",          "command": "workbench.action.files.saveAs" },
    { "key": "shift+ctrl+s",          "command": "workbench.action.files.saveLocalFile",
      "when": "remoteFileDialogVisible" },
    { "key": "ctrl+f",
      "command": "actions.find",
      "when": "editorFocus || editorIsOpen"
    },
]
```
