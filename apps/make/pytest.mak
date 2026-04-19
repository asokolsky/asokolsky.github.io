.DEFAULT_GOAL := help
SHELL := /bin/bash

# Test to run; default one test
TEST ?= test_me.py::test_me
LOG_LEVEL ?= DEBUG
LOG_FORMAT ?= "%(asctime)s.%(msecs)03d %(levelname)s %(filename)s:%(lineno)d - %(message)s"
LOG_DATE_FORMAT ?= "%Y-%m-%d %H:%M:%S"

# Virtual environment
VENV := .venv
PIP := $(VENV)/bin/pip
PYTHON := $(VENV)/bin/python3
PYTEST := $(VENV)/bin/pytest --asyncio-debug --asyncio-mode=auto -v --tb=long \
	--log-cli-level=${LOG_LEVEL} --log-level=${LOG_LEVEL} \
	--log-cli-format=${LOG_FORMAT} --log-format=${LOG_FORMAT} \
	--log-cli-date-format=${LOG_DATE_FORMAT} --log-date-format=${LOG_DATE_FORMAT}


.PHONY: help venv test tests format lint clean

help:								## Show this help
	@echo 'Usage: make [TARGET] [VAR=value ...]'
	@echo ''
	@echo 'Targets:'
	@grep -E '^[a-zA-Z_-]+:.*## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*## "}; {printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}'
	@echo ''
	@echo 'Examples:'
	@echo '  make test            Run default test_self_paced.py::test_allocator_base'
	@echo '  make test TEST=      Run all tests'
	@echo '  make test TEST=test_self_paced.py::test_allocator_base   Run one test'
	@echo ''

venv: $(VENV)/bin/activate			## Create venv and install dependencies

$(VENV)/bin/activate: requirements.txt
	python3 -m venv $(VENV)
	$(PYTHON) -m pip install --upgrade pip
	$(PIP) install -r requirements.txt

test: venv							## Run test (default: test_me.py::test_me)
ifneq ($(strip $(TEST)),)
	$(PYTEST) $(TEST)
else
	$(error No TEST specified)
endif

tests: venv							## Run all tests
	$(PYTEST) test_*.py

format:								## Format python sources
	isort *.py
	ruff format *.py

lint:								## Lint python sources
	isort --check *.py
	ruff check *.py

clean:								## Cleanup the build artifacts
	rm -rf $(VENV) .mypy_cache .pytest_cache .ruff_cache
	find . -name __pycache__ | xargs rm -rf
