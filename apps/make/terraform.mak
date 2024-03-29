.DEFAULT_GOAL := help
SHELL:=/bin/bash
export PROJECT_ROOT = $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

.PHONY: help format docs clean

help: ## Shows the help
	@echo 'Usage: make <TARGETS>'
	@echo ''
	@echo 'Available targets are:'
	@echo ''
	@grep -E '^[ a-zA-Z_-]+:.*?## .*$$' $(shell echo "$(MAKEFILE_LIST)" | tr " " "\n" | sort -r | tr "\n" " ") \
		| sed 's/Makefile[a-zA-Z\.]*://' | sed 's/\.\.\///' | sed 's/.*\///' | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-25s\033[0m %s\n", $$1, $$2}'
	@echo ''

format: ## Run Terraform format
	terraform fmt -recursive $(PROJECT_ROOT)

.guard-%:
	@ if [ "${${*}}" = "" ]; then \
   			printf "\033[0;31m[!] Variable '$*' not set\nSet it with:\n  make $*=<value> target\033[0m\n\n"; \
   			make help; \
   			exit 1; \
   	  fi

docs: .guard-MODULE_NAME ## Build the module documentation
	@echo "> Generating module documentation"
	@sed -i'.bak' '/### Module Documentation/,$$d' $(PROJECT_ROOT)/modules/$(MODULE_NAME)/README.md && rm -f $(PROJECT_ROOT)/modules/$(MODULE_NAME)/README.md.bak
	@printf "### Module Documentation\n\n_Note: This is autogenerated_\n\n" >> $(PROJECT_ROOT)/modules/$(MODULE_NAME)/README.md
	@docker run --rm -v $(PROJECT_ROOT):/data quay.io/terraform-docs/terraform-docs:0.16.0 \
	    markdown table /data/$(MODULE_NAME)/ >> $(PROJECT_ROOT)/modules/$(MODULE_NAME)/README.md


clean: ## Do local clean of terra(form|grunt) artifacts
	find $(PROJECT_ROOT) -type f -name .terraform.lock.hcl -delete
	find $(PROJECT_ROOT) -type d -name .terragrunt-cache -prune -exec rm -fr {} \;
