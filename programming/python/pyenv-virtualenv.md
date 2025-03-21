# Python Virtual Environment

There is [more than one
way](https://bas.codes/posts/python-virtualenv-venv-pip-pyenv-poetry) to
[skin the cat](https://www.youtube.com/watch?v=o1Vue9CWRxU):

* [venv](https://docs.python.org/3/library/venv.html),
[makefile](/apps/make/python.mak)
* [virtulaenv](https://virtualenv.pypa.io/en/latest/)
* [pipx](https://pipx.pypa.io/latest/how-pipx-works/)
* [pyenv](https://github.com/pyenv/pyenv) with
[pyenv-virtualenv](https://github.com/pyenv/pyenv-virtualenv) -
see [How pyenv decides on a python
version](https://github.com/pyenv/pyenv#choosing-the-python-version).

Here we cover pyenv+pyenv-virtualenv on Mac and Linux.

## Install pyenv+pyenv-virtualenv on MacOS

[Install pyenv](https://github.com/pyenv/pyenv#homebrew-in-macos):

```sh
brew update
brew install pyenv
echo 'eval "$(pyenv init --path)"' >> ~/.zprofile
echo 'eval "$(pyenv init -)"' >> ~/.zshrc
```

[Install pyenv-virtualenv](https://github.com/pyenv/pyenv-virtualenv#installing-with-homebrew-for-macos-users):

```sh
brew install pyenv-virtualenv
echo 'eval eval "$(pyenv virtualenv-init -)"' >> ~/.zshrc
```
## Install pyenv+pyenv-virtualenv on Linux

```sh
curl https://pyenv.run | bash
```

added this to .zshenv:
```
# support for pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
```

### Create a Virtual Environment

* create `.python-version`;
* `pyenv`
[uses](https://github.com/pyenv/pyenv#choosing-the-python-version)
python version from `.python-version`;
* `pyenv-virtualenv` [creates and
uses](https://github.com/pyenv/pyenv-virtualenv#activate-virtualenv)
python virtual environment named after `.python-version`.


## Virtual Environment Maintenance

To see the current dependencies as a table:

```sh
pip3 list
```

To freeze:
```sh
pip3 freeze > requirements.txt
```
