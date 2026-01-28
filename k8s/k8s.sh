#!/bin/bash

# Exit on error. Append "|| true" if you expect an error.
set -o errexit
# Exit on error inside any functions or subshells.
set -o errtrace
# Do not allow use of undefined vars. Use ${VAR:-} to use an undefined VAR
set -o nounset
# Catch the error in case mysqldump fails (but gzip succeeds) in `mysqldump |gzip`
set -o pipefail
# Turn on traces, useful while debugging but commented out by default
#set -o xtrace
# Check syntax with `shellcheck ./goto`

case "${1:-unspecified}" in
    "dev" )
        export AWS_PROFILE=dev
        export KUBECONFIG="$HOME/.kube/dev-config" ;
        export VAULT_ADDR=https://vault.dev.fubar.com ;;
    "shared" )
        export AWS_PROFILE=shared
        export KUBECONFIG="$HOME/.kube/shared-config" ;
        export VAULT_ADDR=https://vault.shared.fubar.com ;;
    "stage" )
        export AWS_PROFILE=stage
        export KUBECONFIG="$HOME/.kube/stage-config" ;
        export VAULT_ADDR=https://vault.stage.fubar.com ;;
    "prod" )
        export AWS_PROFILE=prod
        export KUBECONFIG="$HOME/.kube/prod-config" ;
        export VAULT_ADDR=https://vault.prod.fubar.com ;;
    "security" )
        export AWS_PROFILE=security
        export KUBECONFIG="$HOME/.kube/security-config" ;
        export VAULT_ADDR=https://vault.security.fubar.com ;;
    *)
        echo "k8s [dev|stage|prod|shared|security]"
        exit 1
esac

export AWS_DEFAULT_REGION=us-east-1
export AWS_PAGER=''

aws sso login
#aws sts get-caller-identity
/bin/zsh
