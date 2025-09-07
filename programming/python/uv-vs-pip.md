# uv vs. pip

Notes from https://realpython.com/uv-vs-pip/

Task|pip|uv
----|---|--
create venv|`python -m venv .venv`|`uv venv .venv`
clean venv cache|`python -m pip cache purge`|`uv cache clean`
install package|`python -m pip install jupyterlab`|`uv pip install jupyterlab`
add package||`uv add requests`
remove package|`python -m pip uninstall requests`|`uv remove requests`
install deps|`python -m pip install -r requirements.txt`|`uv pip install -r requirements.txt`
pin your deps|`python -m pip freeze > requirements.txt`|`uv.lock` file
list deps|`python -m pip list`|`uv pip list`
remove transitive deps||`uv remove requests`