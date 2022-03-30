# Total Isolation with pyenv and pyenv-virtualenv

[pyenv](https://github.com/pyenv/pyenv) allows for isolating from system python installed
while [pyenv-virtualenv](https://github.com/pyenv/pyenv-virtualenv) adds support to
virtual environments.

For more information read [How pyenv decides on a python
version](https://github.com/pyenv/pyenv#choosing-the-python-version).

## Installation on MacOS

[Install pyenv](https://github.com/pyenv/pyenv#homebrew-in-macos):

```
brew update
brew install pyenv
echo 'eval "$(pyenv init --path)"' >> ~/.zprofile
echo 'eval "$(pyenv init -)"' >> ~/.zshrc
```

[Install pyenv-virtualenv](https://github.com/pyenv/pyenv-virtualenv#installing-with-homebrew-for-macos-users):
```
brew install pyenv-virtualenv
echo 'eval eval "$(pyenv virtualenv-init -)"' >> ~/.zshrc
```

### Create a Virtual Environment

* create `.python-version`;
* `pyenv`
[uses](https://github.com/pyenv/pyenv#choosing-the-python-version)
python version from `.python-version`;
* `pyenv-virtualenv` [creates and
uses](https://github.com/pyenv/pyenv-virtualenv#activate-virtualenv)
python virtual environment named after `.python-version`.

