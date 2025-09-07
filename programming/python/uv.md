# uv

[repo](https://github.com/astral-sh/uv), [documentation](https://docs.astral.sh/uv).
See also [uv-vs-pip](./uv-vs-pip.html).

## Install uv

Few options:

* from your os repos
* as a python package: `pipx install uv`

Upgrade to the latest version:

* `uv self update`
* or with `pipx upgrade uv`

## Managing Python Project With `uv`

### Create Project

```sh
uv init my-project
```

creates:
```
my-project/
│
├── .git/
│
├── .gitignore
├── .python-version
├── README.md
├── main.py
└── pyproject.toml
```

Alternatively run `uv init` while inside the existing project directory.

### Run the Project’s Entry-Point

```sh
uv run main.py
```

## Project Script

Add to `pyproject.toml`:
```
[project.scripts]
my-project = "main:main"
```

This ensures that when someone installs your package, they can run the `my-project` command from CLI to execute `main.py:main()` function.

### Add Project Dependency

https://docs.astral.sh/uv/concepts/projects/dependencies/

```sh
uv add requests
```
This adds
```
dependencies = [
    "requests>=2.32.3",
]
```
to `pyproject.toml`.

Alternatively, to add the dependencies from `requirements.txt`:

```sh
uv add -r requirements.txt
```

### Upgrade Project Dependency

```sh
uv add --upgrade requests
```

### Remove Project Dependency

```sh
uv remove package_name
```

### List Project Dependencies

To list the dependencies:
```sh
uv pip list
```

### Project Dependency Groups

```sh
uv add --dev pytest
```

Adds to `pyproject.toml`:
```
[dependency-groups]
dev = [
    "pytest>=8.3.5",
]
```

## Locking and Synching the Environment

`uv` uses the `uv.lock` file to lock a project’s dependencies.

Locking captures the project dependencies in the lockfile.

Syncing is installing the required packages from the lockfile into the project’s development environment.

What `uv run` does:

* locks the project
* synchs the project
* invokes the the command passed

## Build the Package

Use [setuptools](https://setuptools.pypa.io/en/latest/) as the build system, add these lines to `pyproject.toml`:

```
[build-system]
requires = ["setuptools>=78.1.0", "wheel>=0.45.1"]
build-backend = "setuptools.build_meta"
```

To build the project and place the distributions into a `dist` subdirectory:
```sh
uv build
```

Alternatively to build a [source distribution](https://packaging.python.org/en/latest/glossary/#term-Source-Distribution-or-sdist) only:
```sh
uv build --sdist
```

To build a [binary distribution](https://packaging.python.org/en/latest/glossary/#term-Binary-Distribution) only:
```sh
uv build --wheel
```

## Publish the Package

https://realpython.com/pypi-publish-python-package/

### Publish to the test repo

Start with publishing to the test repo https://test.pypi.org/.  You need an account there and an API token.

Add these to `pyproject.toml`:

```
[[tool.uv.index]]
name = "testpypi"
url = "https://test.pypi.org/simple/"
publish-url = "https://test.pypi.org/legacy/"
explicit = true
```

Publish with:
```sh
uv publish --index testpypi --token your_token_here
```

### Test the package from the test repo

In a new directory:
```sh
uv venv
uv pip install -i https://test.pypi.org/simple/ my-project
```

### Publish to the PyPI

Again, you need to have an [account](https://pypi.org/account/register/) and an API token.

```sh
uv publish --token your_token_here
```
