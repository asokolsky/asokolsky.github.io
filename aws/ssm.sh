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

function usage {
    echo "Usage: $0 [username@]<instanceID>"
    echo "       $0 i-0cf519030f32da9ab"
    echo "       $0 ubuntu@i-0cf519030f32da9ab"
    echo "Assumed: aws cli, aws session established"
}

function ssm_username_to_instance {
    IFS='@'
    local elts=($1)
    local username="${elts[0]}"
    local id="${elts[1]}"
    echo "ssm_username_to_instance $username@$id"
    aws ssm start-session --document-name AWS-StartInteractiveCommand --parameters "{\"command\": [\"sudo su $username\"]}" --target "$id"
}

function ssm_to_instance {
    local id="$1"
    echo "ssm_to_instance $id"
    aws ssm start-session --target "$id"
}

if [ "$#" -eq 0 ] || [ "$#" -ge 2 ]; then
   usage
elif [[ $1 =~ ^[a-zA-Z._%+-]+@i-[0-9a-f]+$ ]]; then
   echo "$1 is username@instance"
   ssm_username_to_instance "$1"
elif [[ $1 =~ ^i-[0-9a-f]+$ ]]; then
   echo "$1 is an AWS EC2 instance ID"
   ssm_to_instance "$1"
else
   usage
fi
