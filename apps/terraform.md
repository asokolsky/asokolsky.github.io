# Terraform Cheat Sheet

From

* https://nicwortel.nl/cheat-sheets?ref=Terraform+Cheat+Sheet
* https://developer.hashicorp.com/terraform/cli/commands


## Installation

See https://developer.hashicorp.com/terraform/downloads.

Then run terraform -install-autocomplete to enable shell autocompletion.

## Initializing Terraform

Command|Description
-------|-----------
`terraform init`|[Prepare your working directory](https://developer.hashicorp.com/terraform/cli/commands/init) for other commands
`terraform init -upgrade`|Upgrade modules/providers to the latest allowed versions
`terraform get`|[Download and install](https://developer.hashicorp.com/terraform/cli/commands/get) modules

## Provisioning Infrastructure

Command|Description
-------|-----------
`terraform plan`|[Show changes](https://developer.hashicorp.com/terraform/cli/commands/plan) required by the current configuration
`terraform plan -out=<file>`|Write the plan to a file to apply it later
`terraform plan -target <res1> -target <res2>`|Create a plan for the specific resource(s)
`terraform plan -replace <resource>`|Force the plan to replace a specific resource
`terraform plan -var '<key>=<value>'`|Set a value for one of the input variables
`terraform plan -refresh-only`|Inspect resource drift without updating the state file
`terraform apply`|[Create or update](https://developer.hashicorp.com/terraform/cli/commands/apply) infrastructure
`terraform apply <file>`|Create or update infrastructure using a plan file
`terraform apply -target <resource>`|Create or update a specific resource
`terraform apply -replace <resource>`|Force the replacement of a specific resource
`terraform apply -auto-approve`|Skip interactive approval of plan before applying
`terraform destroy`|[Destroy the infrastructure](https://developer.hashicorp.com/terraform/cli/commands/destroy) managed by Terraform
`terraform destroy -target <resource>`|Destroy a specific resource

Selective apply to target:
```sh
terraform apply -target="aws_autoscaling_group.foo-bar-asg"
```

## Inspecting Infrastructure

Command|Description
-------|-----------
`terraform output`|[Show all the output values](https://developer.hashicorp.com/terraform/cli/commands/output)
`terraform output -json`|Show all output values in JSON format
`terraform output <name>`|Show a specific output value
`terraform output -raw <name>`|Show a specific output value without quotes
`terraform show`|[Show the current state](https://developer.hashicorp.com/terraform/cli/commands/show) in human-readable form
`terraform show -no-color >file.txt`|Save into a file
`terraform show <file>`|Show a human-readable state or plan file
`terraform show -json <file>`|Show a state or plan file in JSON format

## Managing state

Command|Description
-------|-----------
`terraform state list`|[List all the resources](https://developer.hashicorp.com/terraform/cli/commands/state/list) in the state file
`terraform state show <resource>`|[Show details](https://developer.hashicorp.com/terraform/cli/commands/state/show) about a resource
`terraform state mv <source> <dest>`|Rename a resource in the state file
`terraform state rm <resource>`|Remove a resource from the state file
`terraform state replace-provider <from> <to>`|Replace provider for resources in the state
`terraform import <resource> <remote_id>`|[Import the existing infrastructure](https://developer.hashicorp.com/terraform/cli/commands/import)
`terraform state pull`|Pull current state and output to stdout
`terraform refresh`|(Deprecated) [Update state](https://developer.hashicorp.com/terraform/cli/commands/refresh) to match reality

## Formatting and validation

Command|Description
-------|-----------
`terraform validate`|[Check](https://developer.hashicorp.com/terraform/cli/commands/validate) whether the configuration is valid
`terraform fmt`|[Reformat](https://developer.hashicorp.com/terraform/cli/commands/fmt) your configuration in the standard style
`terraform fmt -check`|Check whether the configuration is formatted correctly, return non-zero exit code if not


## Other commands
Command|Description
-------|-----------
`terraform providers`|Show the providers required for this configuration
`terraform force-unlock <lock-id>`|Release a stuck lock
`terraform console`|[Try Terraform expressions](https://developer.hashicorp.com/terraform/cli/commands/console) at an interactive prompt
`terraform graph \| dot -Tpng > graph.png`|[Outputs](https://developer.hashicorp.com/terraform/cli/commands/graph) a dot-formatted graph which can be viewed with [graphviz](https://graphviz.org/download/)
`terraform version`|Show the current Terraform version
`terraform -help`|Show help output for Terraform
`terraform -help <command>`|Show help output for a specific Terraform command

## Environment Variables

[Details](https://developer.hashicorp.com/terraform/cli/config/environment-variables)

Most relevant:
```sh
export TF_LOG=TRACE
```
Acceptable options:

* TRACE
* DEBUG
* INFO
* WARN
* ERROR
* JSON - outputs logs at the TRACE level or higher, and uses a parseable
JSON encoding as the formatting.

## Makefile

Example [terraform Makefile](make/terraform.mak).

## Missing assert

https://github.com/ahl/terrassert/
