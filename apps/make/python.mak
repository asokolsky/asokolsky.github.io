
# define the name of the virtual environment directory
VENV:=.venv

PYTHON=$(VENV)/bin/python3
PIP=$(VENV)/bin/pip

# targets which are NOT files
.PHONY: all venv run clean

# default target, when make executed without arguments
all: venv

# venv is a shortcut target
venv: $(VENV)/bin/activate

$(VENV)/bin/activate: requirements.txt
	python3 -m venv $(VENV)
	$(PIP) install -r requirements.txt

run: venv
	$(PYTHON) app.py

test: venv
	$(PYTHON) -m unittest -v *_test.py

clean:
	rm -rf $(VENV) .mypy_cache
	find . -name __pycache__ | xargs rm -rf

#
# Usage: make VENV=my_venv run
#
