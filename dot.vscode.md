# Visual Studio Code Settings

Depending on the platform, the user `settings.json` is in:

* Windows:  `%APPDATA%\Code\User\`
* macOS: `/Users/{username}/Library/Application Support/Code/User/`
* Linux `$HOME/.config/Code/User/`

My `seetings.json`:

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
