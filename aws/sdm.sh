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

function sdm_by_sname {
    local sname=$1
    echo "sdm_by_sname $sname"
    sdm ssh "$sname"
}

function sdm_by_instance_id {
    local id=$1
    # remove leading and trailing " if present
    id="${id%\"}"
    id="${id#\"}"
    echo "sdm_by_instance_id $id"
    IFS=' '
    local line=$(sdm status|grep $id)
    if [ -z "$line" ]; then
        echo "sdm has no knowledge of $id"
    else
        local elts=($line)
        local sname="${elts[0]}"
        sdm_by_sname "$sname"
    fi
}

function sdm_by_ip {
    # convert ip to an instance ID
    local ip="$1"
    echo "sdm_by_ip $ip"

    local reservations=$(aws ec2 describe-instances --filter Name=private-ip-address,Values="$ip"|jq .Reservations[])
    if [ -z "$reservations" ]; then
        echo "Failed to aws-describe $ip into instance id"
    else
        local id=$(jq '.Instances[0].InstanceId' <<< "$reservations")
        if [ -z "$id" ]; then
            echo "Failed to aws-resolve $ip into instance id"
        else
            sdm_by_instance_id "$id"
        fi
    fi
}

function sdm_by_host {
    local host="$1"
    echo "sdm_by_host $host"

    # aws ec2 describe-instances --filters 'Name=tag:Name,Values=$host'
    local reservations=$(aws ec2 describe-instances --filter "Name=tag:Name,Values=$host"|jq .Reservations[])
    if [ -z "$reservations" ]; then
        echo "Failed to aws-describe $host into instance id"
    else
        local id=$(jq '.Instances[0].InstanceId' <<< "$reservations")
        if [ -z "$id" ]; then
            echo "Failed to aws-resolve $host into instance id"
        else
            sdm_by_instance_id "$id"
        fi
    fi
}

function sdm_by_fqdn {
    local fqdn="$1"
    echo "sdm_by_fqdn $fqdn"
    IFS=.
    local elts=($fqdn)
    local name="${elts[0]}"
    sdm_by_host "$name"
}

function usage {
    echo "Usage: $0 <ip|fqdn|host-name|instanceID>"
    echo "       $0 10.6.64.87"
    echo "       $0 i-053ff6b5474ff1f12"
    echo "       $0 zookeeper-steelix-23"
    echo "Assumed: aws, jq, sdm cli installed, aws session established"
}

if [ "$#" -eq 0 ] || [ "$#" -ge 2 ]; then
    usage
elif [[ $1 =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    #echo "$1 is an IP address"
    sdm_by_ip "$1"
elif [[ $1 =~ ^i-[0-9a-f]+$ ]]; then
    #echo "$1 is an AWS EC2 instance ID"
    sdm_by_instance_id "$1"
elif [[ $1 =~ .\.. ]]; then
    #echo "$1 is a FQDN"
    sdm_by_fqdn "$1"
else
    #echo "$1 is a short host name"
    sdm_by_host "$1"
fi
