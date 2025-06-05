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
	@grep -E '^[ a-zA-Z_-]+:.*?## .*$$' $(shell echo "$(MAKEFILE_LIST)" | tr " " "\n" | sort -r | tr "\n" " ") \
		| sed 's/Makefile[a-zA-Z\.]*://' | sed 's/\.\.\///' | sed 's/.*\///' | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-25s\033[0m %s\n", $$1, $$2}'
	@echo ''

# venv is a shortcut target
venv: $(VENV)/bin/activate                  ## Activate the venv

$(VENV)/bin/activate: requirements.txt
	python3 -m venv $(VENV)
	$(PIP) install -r requirements.txt

lint: venv                                  ## Lint python sources
	-flake8 *.py
	-mypy *.py

run: venv									## Execute python program
	$(PYTHON) main.py $(SITE)

test: venv									## Execute python tests
	$(PYTHON) -m unittest -v *_test.py

clean:										## Cleanup the artifacts
	rm -rf $(VENV) .mypy_cache
	find . -name __pycache__ | xargs rm -rf

DOCKER_USERNAME ?= john.doe
APPLICATION_NAME ?= da-app
GIT_HASH ?= $(shell git log --format="%h" -n 1)

build:								## Build docker image
	docker build --tag ${DOCKER_USERNAME}/${APPLICATION_NAME}:${GIT_HASH} .

release:							## Release docker image
	cat ./.docker-password | docker login --username ${DOCKER_USERNAME} --password-stdin
	docker push ${DOCKER_USERNAME}/${APPLICATION_NAME}:${GIT_HASH}
	docker pull ${DOCKER_USERNAME}/${APPLICATION_NAME}:${GIT_HASH}
	docker tag  ${DOCKER_USERNAME}/${APPLICATION_NAME}:${GIT_HASH} ${DOCKER_USERNAME}/${APPLICATION_NAME}:latest
	docker push ${DOCKER_USERNAME}/${APPLICATION_NAME}:latest
