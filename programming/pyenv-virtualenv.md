# Python Virtual Environment

There is [more than one
way](https://bas.codes/posts/python-virtualenv-venv-pip-pyenv-poetry) to
[skin the cat](https://www.youtube.com/watch?v=o1Vue9CWRxU):

* venv
* [virtulaenv](https://virtualenv.pypa.io/en/latest/)
* [pyenv](https://github.com/pyenv/pyenv) with
[pyenv-virtualenv](https://github.com/pyenv/pyenv-virtualenv) -
see [How pyenv decides on a python
version](https://github.com/pyenv/pyenv#choosing-the-python-version).

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

### Create a Virtual Environment

* create `.python-version`;
* `pyenv`
[uses](https://github.com/pyenv/pyenv#choosing-the-python-version)
python version from `.python-version`;
* `pyenv-virtualenv` [creates and
uses](https://github.com/pyenv/pyenv-virtualenv#activate-virtualenv)
python virtual environment named after `.python-version`.
