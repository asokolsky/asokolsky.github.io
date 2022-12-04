# Publishing on PyPI

https://packaging.python.org/en/latest/guides/distributing-packages-using-setuptools/


## Prepare the folder

```sh
mkdir foobar
cd foobar
python3 -m venv venv
source venv/bin/activate
pip install wheel setuptools twine ...
```

## Build it

```sh
python3 setup.py bdist_wheel
```

## Install it for local use

```sh
pip install --no-index --find-links=dist/foobar-0.0.1-py3-none-any.whl  foo-bar
```
