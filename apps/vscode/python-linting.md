# Change in VS Code Python Linting

I use flake and mypy to lint my python projects in vscode.  Today when I opened
my python project I noticed:

```
[error] All settings starting with "python.linting." are deprecated and can be removed from settings.
[error] Linting features have been moved to separate linter extensions.
[error] See here for more information: https://code.visualstudio.com/docs/python/linting
[error] Please install "flake8" extension: https://marketplace.visualstudio.com/items?itemName=ms-python.flake8
[error] Please install "mypy" extension: https://marketplace.visualstudio.com/items?itemName=ms-python.mypy-type-checker
```

Well, the good news is.. the error message is actionable:

1. Install `mypy-type-checker` extension, NOT `mypy` extension. You need the one
from Microsoft, not from Matan Gover.
2. Install `flake8` extension.
3. Modify your project `.vscode/settings.json`:

* remove `python.linting.*` settings.
* add
[mypy extension settings](https://github.com/microsoft/vscode-mypy?tab=readme-ov-file#settings)
and [flake extension settings](https://github.com/microsoft/vscode-flake8?tab=readme-ov-file#settings).
All I needed was to move value of `python.linting.mypyArgs` to
`mypy-type-checker.args`.
