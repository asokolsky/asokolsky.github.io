# Visual Studio Code Settings for Python

https://code.visualstudio.com/docs/python/python-tutorial

## Workspace


https://code.visualstudio.com/docs/python/debugging

`.vscode/launch.json`:

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

`.vscode/settings.json`

https://code.visualstudio.com/docs/python/settings-reference

```json
{
    "python.linting.enabled": true,
    "python.linting.mypyEnabled": true,
    "python.linting.mypyArgs": [
        "--ignore-missing-imports",
        "--follow-imports=silent",
        "--show-column-numbers",
        "--strict"
    ],
    "python.linting.pylintEnabled": false,
    "python.linting.pylintUseMinimalCheckers": false,
    "python.linting.flake8Enabled": true,
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

You can tell I like unittest and `mypy`, not `pylint` and `pytest`.

## More Repo files

`.flake8`:

```
[flake8]
extend-ignore = E127,E128,E231,E265,E302,E501
exclude = doc,.git,.mypy_cache,__pycache__,.vscode
max-complexity = 20
```


`.gitignore`

```
__pycache__/
__pypackages__/

venv/

.scrapy


# mypy
.mypy_cache/
.dmypy.json
dmypy.json

*.log
```

`mypy.ini`

```
[mypy-recurrent.*]
ignore_missing_imports = True

```
