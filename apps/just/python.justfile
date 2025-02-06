# define the name of the virtual environment directory

VENV := '.venv'
PYTHON := VENV + '/bin/python3'
PIP := VENV + '/bin/pip'

_default:
    @#	@ echo "No default task specified."
    @just -f {{ justfile() }} --list

# Create the venv
venv:
    python -m venv {{ VENV }}
    {{ PIP }} install -r requirements.txt

# Activate the venv
_activate:
    . {{ VENV }}/bin/activate

# Execute python program
run SITE='asokolsky.github.io': _activate
    {{ PYTHON }} main.py -v {{ SITE }}

# Execute python tests
test: _activate
    {{ PYTHON }} -m unittest -v *_test.py

# Cleanup the build/lint/test artifacts
clean:
    rm -rf {{ VENV }} .mypy_cache
    find . -name __pycache__ | xargs rm -rf
