# Visual Studio Code Settings for Python

See
[Getting Started with Python in VS Code](https://code.visualstudio.com/docs/python/python-tutorial)
and then
[Python environments in VS Code](https://code.visualstudio.com/docs/python/environments).
Note the
[use of .env file](https://code.visualstudio.com/docs/python/environments#_environment-variable-definitions-file)

## Workspace Files

### `.vscode/launch.json`:

See https://code.visualstudio.com/docs/python/debugging

```json
{
    // Use IntelliSense to learn about possible attributes.
    // Hover to view descriptions of existing attributes.
    // For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Python: Current File",
            "type": "python",
            "request": "launch",
            "program": "${file}",
            "console": "integratedTerminal",
            "justMyCode": false,
            "args": ["--pythonpath", "/foo/bar", "mqtt", "cpu_percent"],
        }
    ]
}
```

Here are
[the variables](https://code.visualstudio.com/docs/editor/variables-reference)
to use.

### `.vscode/settings.json`

Also see [python-linting](python-linting.html) and
[settings-reference](https://code.visualstudio.com/docs/python/settings-reference).

```json
{
    "mypy-type-checker.args": [
        "--ignore-missing-imports",
        "--follow-imports=silent",
        "--show-column-numbers",
        "--strict"
    ],
    "python.testing.pytestEnabled": false,
    "python.testing.unittestEnabled": true,
    "python.testing.unittestArgs": [
        "-v",
        "-s",
        ".",
        "-p",
        "*_test.py"
    ],
    "cSpell.words": [
        "scrapy"
    ]
}
```

You can tell I like `unittest` and `mypy`, not `pylint` and `pytest`.

### `.flake8`

```
[flake8]
extend-ignore = E127,E128,E231,E265,E302,E501
exclude = doc,.git,.mypy_cache,__pycache__,.vscode
max-complexity = 20
```


### `.gitignore`

See https://github.com/asokolsky/aws-describe/blob/master/.gitignore

### `mypy.ini`

```
[mypy-recurrent.*]
ignore_missing_imports = True
```
