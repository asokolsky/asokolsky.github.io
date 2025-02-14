# This is the base directory for this repo
BASE_DIR:=$(dir $(realpath $(lastword $(MAKEFILE_LIST))))

# The desired version of Tanka
TANKA_VERSION := 0.31.2
TANKA_VERSION_ACTUAL := $(shell (tk --version 2>&1 |sed -e "s/^.*version //"))

# Gather all libsonnet tests
LIBSONNET_TESTS=$(wildcard tests/*.jsonnet)

# Gather all docs files. Maybe we should do this via lib level configuration rather than repo level convention
DOCSONNET_FILES=$(wildcard lib/*/docs.jsonnet)

.PHONY: all
all: check-tanka-version fmt compile policy test

#
# Enforce tanka version
#
.PHONY: check-tanka-version
check-tanka-version:
ifeq ($(TANKA_VERSION_ACTUAL),$(TANKA_VERSION))
	@echo "Confirmed tanka version $(TANKA_VERSION)"
else
	@echo "Detected tanka version $(TANKA_VERSION_ACTUAL), expected $(TANKA_VERSION). Upgrade tanka using 'brew upgrade tanka'.";
endif

.PHONY: compile
compile:
	tk env -V 'rootDir=$(shell pwd)' list --json | jq > lib/imported/environments.json
	@# we need to add a flag for `--merge-deleted-envs` for each env which is no longer present
	@# for now we're mashing this up in bash; but if this gets much more complex we may wrap
	@# this whole thing in a python script
	tk export -V 'rootDir=$(shell pwd)' releases environments/ --recursive --format '{{env.metadata.labels.cluster}}/{{ if .metadata.namespace}}{{.metadata.namespace}}{{ else }}{{ if eq .kind "Namespace"}}{{.metadata.name}}{{ else }}global{{end}}{{end}}/{{.kind}}-{{.metadata.name}}' -c .cache --merge-strategy replace-envs $(shell ./scripts/missing_envs.py | sed 's/^/--merge-deleted-envs /')
	@# prune empty directories if we created any
	find releases/ -type d -empty -delete

.PHONY: vendor
vendor:
	@# re-run vendoring for helm-chars (ensure no local modifications)
	tk tool charts vendor --prune
	@# re-run vendoring for jsonnet bundler (ensure no local modifications)
	jb install

.PHONY: fmt
fmt:
	tk fmt .

# Note: this should be run from the "security" account
# pull all remote imported data
.PHONY: imports
imports:
	scripts/imports/import_aws_sso.py  > lib/imported/aws_sso.json

.PHONY: docs
docs:
	./scripts/generate_library_docs.py

.PHONY: test
test: prepare-venv
	@# run libsonnet tests
	for test in $(LIBSONNET_TESTS); do bash -c "jsonnet --jpath lib/ --jpath vendor/ $$test 1> /dev/null"; done
	@# Run our local python tests for ensuring policy has been met
	.venv/bin/python3 scripts/test.py
	@# run kubeconform tests to ensure the manifests we have are valid
	kubeconform -schema-location default -cache .cache -strict -skip CustomResourceDefinition,Jenkins,OperatorConfiguration,postgresql,OpenTelemetryCollector,Detector,Agent,ClusterAgent -schema-location 'https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/{{.Group}}/{{.ResourceKind}}_{{.ResourceAPIVersion}}.json' releases/*/*

.PHONY: clean
clean:
	@# clean out the releases directory of any extraneous files
	git clean -dfx -- releases/
	@# reset any releases files to their upstream state
	git checkout releases/
	@# ensure that environments.json is *also* reset (since it is also generated)
	git checkout lib/imported/environments.json
	@# clean tanka cache
	rm -rf .cache

.PHONY: clean-all
clean-all:
	git clean -dfx
	git checkout .
	@# clean tanka cache
	rm -rf .cache

# setup the various git configuration for this repo
.PHONY: setup
setup:
	git config merge.json-manifest.name "merge manifests.json"
	git config merge.json-manifest.driver "${BASE_DIR}scripts/jsonmanifestmerge.py %O %A %B"

# set CLUSTER based on AWS_VAULT=<cluster-name>-from-security
ifndef CLUSTER
CLUSTER=$(word 1,$(subst -, ,${AWS_VAULT}))
endif
#
# set RELEASE_FOLDER based on CLUSTER
#
ifeq (${CLUSTER},prod)
RELEASE_FOLDER=releases/986773245096.vpc-0614978834b80f859.prod/
else ifeq (${CLUSTER},stage)
RELEASE_FOLDER=releases/523755665336.vpc-06fd62317bef41c7b.stage/
else ifeq (${CLUSTER},shared)
RELEASE_FOLDER=releases/285088940395.vpc-05de3d3f5400d6a2f.test/
else ifeq (${CLUSTER},dev)
RELEASE_FOLDER=releases/849649743722.vpc-0fe6a9c124e4d109f.test/
else
RELEASE_FOLDER=undefined
endif
#
# e.g `make CLUSTER=foo apply`, if omitted, derives CLUSTER from AWS_VAULT
#
.PHONY: apply
apply:
ifeq (${RELEASE_FOLDER},undefined)
	@echo "Unknown CLUSTER ${CLUSTER}"
else
	@echo "CLUSTER=${CLUSTER}"
	kubectl apply -Rf ${RELEASE_FOLDER}
endif

.PHONY: prepare-venv
prepare-venv:
# Setup Python virtual environment with required packages
	test -d .venv || python3 -m venv .venv
	.venv/bin/pip install --disable-pip-version-check --quiet Jinja2 PyYAML
