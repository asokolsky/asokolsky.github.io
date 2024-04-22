.DEFAULT_GOAL := help

export TEMPLATE ?=
export PACKAGE = $(TEMPLATE)
export AWS_TARGET_AMI = $(PACKAGE)-all-$(shell date '+%Y%m%d%H%M%S')-focal
export PACKER_DRY_RUN ?= true
export PACKER_DEBUG ?= 0
export PACKER_OPTS ?= -on-error=ask -timestamp-ui  -var packages=$(PACKAGE) -var aws_target_ami=$(AWS_TARGET_AMI)
ifeq ($(PACKER_DEBUG), 1)
PACKER_OPTS += -debug
endif

export GOSS_PROVISIONER_VERSION=v3.1.3
export AWS_DEFAULT_REGION ?= us-east-1

PACKER_SCRATCH_DIR=/tmp/packer
#
# Build
#
bake: .guard-TEMPLATE .install validate-shell validate-packer ## Generate an AMI
	@rm -f build-$(TEMPLATE).log
	@echo "Building AMI, logging into build-$(TEMPLATE).log..."
	> build-$(TEMPLATE).log
	@ if [ "${PACKER_DRY_RUN}" = "true" ]; then \
		echo "> Skipping creation and publishing of final AMI"; \
		PACKER_LOG=1 PACKER_LOG_PATH=build-$(TEMPLATE).log packer build -var 'aws_skip_create_ami=true' $(PACKER_OPTS) "$(TEMPLATE).pkr.hcl"; \
	else \
		echo "> Ensure creation and publishing of final AMI"; \
		PACKER_LOG=1 PACKER_LOG_PATH=build-$(TEMPLATE).log packer build -var 'aws_skip_create_ami=false' $(PACKER_OPTS) "$(TEMPLATE).pkr.hcl"; \
	fi
#	@rm -f build-$(TEMPLATE).log

#
# Validation
#
validate: .install validate-shell validate-packer ## Run all validation routines

validate-shell: ## Run shellcheck for all scripts in scripts dir
	find scripts/ -type f  | xargs shellcheck

validate-packer: ## Validate packer templates
	ls ami-*  | xargs -I{} packer validate  -var packages=$(PACKAGE) -var aws_target_ami=$(AWS_TARGET_AMI) {}

#
# Utils
#
.install:
	@mkdir -p "${PACKER_SCRATCH_DIR}" || true
	@test -f "${PACKER_SCRATCH_DIR}/packer-provisioner-goss.tgz" || curl -L -o "${PACKER_SCRATCH_DIR}/packer-provisioner-goss.tgz" https://github.com/YaleUniversity/packer-provisioner-goss/releases/download/${GOSS_PROVISIONER_VERSION}/packer-provisioner-goss-${GOSS_PROVISIONER_VERSION}-$(or $(shell uname -s | tr A-Z a-z), linux)-amd64.tar.gz
	@tar xfz "${PACKER_SCRATCH_DIR}/packer-provisioner-goss.tgz" -C /tmp/ && mv /tmp/packer-provisioner-goss .
	@chmod +x "packer-provisioner-goss"

.guard-%:
	@ if [ "${${*}}" = "" ]; then \
		printf "\033[0;31m[!] Variable '$*' not set\nSet it with:\n  make $*=<value> target\033[0m\n\n"; \
		make help; \
		exit 1; \
	fi

.PHONY: bake validate validate-packer validate-shell

help: ## Shows the help
	@echo 'Usage: make <OPTIONS> ... <TARGETS>'
	@echo ''
	@echo 'Available targets are:'
	@echo ''
	@grep -E '^[ a-zA-Z_-]+:.*?## .*$$' $(shell echo "$(MAKEFILE_LIST)" | tr " " "\n" | sort -r | tr "\n" " ") \
		| sed 's/Makefile[a-zA-Z\.]*://' | sed 's/\.\.\///' | sed 's/.*\///' | \
        awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-25s\033[0m %s\n", $$1, $$2}'
	@echo ''
