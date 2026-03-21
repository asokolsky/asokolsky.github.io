.DEFAULT_GOAL := help
SHELL:=/bin/bash
export PROJECT_ROOT = $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

# define the name of the virtual environment directory
VENV:=.venv

PYTHON=$(VENV)/bin/python3
PIP=$(VENV)/bin/pip

# targets which are NOT files
.PHONY: help venv run test clean build lint

help:										## Shows the help
	@echo 'Usage: make <TARGETS>'
	@echo ''
	@echo 'Available targets are:'
	@echo ''
	@grep -E '^[a-zA-Z_-]+:.*## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*## "}; {printf "\033[36m%-25s\033[0m %s\n", $$1, $$2}'
	@echo ''

# venv is a shortcut target
venv: $(VENV)/bin/activate                  ## Activate the venv

$(VENV)/bin/activate: requirements.txt
	python3 -m venv $(VENV)
	$(PYTHON) -m pip install --upgrade pip
	$(PIP) install -r requirements.txt

pre-commit-install: venv					## Install pre-commit hooks
	pre-commit install --hook-type pre-commit --hook-type commit-msg --hook-type pre-push

pre-commit-uninstall: venv					## Uninstall pre-commit hooks
	pre-commit uninstall

clean:										## Cleanup the artifacts
	rm -rf $(VENV) .mypy_cache
	find . -name __pycache__ | xargs rm -rf
