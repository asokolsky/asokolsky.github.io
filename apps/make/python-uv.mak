.DEFAULT_GOAL := help
SHELL:=/bin/bash
export PROJECT_ROOT = $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

# define the name of the virtual environment directory
VENV:=.venv

# targets which are NOT files
.PHONY: help venv run test clean build lint format

help:										## Shows the help
	@echo 'Usage: make <TARGETS>'
	@echo ''
	@echo 'Available targets are:'
	@echo ''
	@grep -E '^[ a-zA-Z_-]+:.*?## .*$$' $(shell echo "$(MAKEFILE_LIST)" | tr " " "\n" | sort -r | tr "\n" " ") \
		| sed 's/Makefile[a-zA-Z\.]*://' | sed 's/\.\.\///' | sed 's/.*\///' | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-25s\033[0m %s\n", $$1, $$2}'
	@echo ''

format:	 	                                ## Format python sources
	uv run isort *.py
	uv run ruff format *.py

lint:	 	                                ## Lint python sources
	uv run isort --check *.py
	uv run ruff check *.py

run: 										## Execute python program
	uv run main.py $(SITE)

test: 										## Execute python tests
	uv run -m unittest -v *_test.py

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
