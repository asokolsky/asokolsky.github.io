#!/usr/bin/env bash
#
# Given an AWS ALB ARN, find all the target groups with 0 targets
#
# Exit on error. Append "|| true" if you expect an error.
set -o errexit
# Exit on error inside any functions or subshells.
#set -o errtrace
# Do not allow use of undefined vars. Use ${VAR:-} to use an undefined VAR
set -o nounset
# Catch the error in case mysqldump fails (but gzip succeeds) in `mysqldump |gzip`
set -o pipefail
# Turn on traces, useful while debugging but commented out by default
#set -o xtrace

lb_arn=$1
# e.g. arn:aws:elasticloadbalancing:us-east-1:374926383693:loadbalancer/app/frontend-prb-staging-internal-lb/bdc22951cd7a5c10

#listener_port=443
listener_arn=$(aws elbv2 describe-listeners --load-balancer-arn "$lb_arn" --query='Listeners[?Port==`443`]' | jq -r ".[0].ListenerArn")

#typeset -A target_group_arn_to_listener_rule_arn
#rules=$(aws elbv2 describe-rules --listener-arn "$listener_arn" | jq -c ".Rules[]")
#for rule in $rules; do
#    #echo $rule
#    rule_arn=$(jq -r ".RuleArn" <<< $rule)
#    #echo "rule_arn=$rule_arn"
#    tg_arn=$(jq -r ".Actions[0].TargetGroupArn" <<< $rule)
#    #echo "tg_arn=$tg_arn"
#    target_group_arn_to_listener_rule_arn[$tg_arn]=$rule_arn
#done
#echo $target_group_arn_to_listener_rule_arn

groups=$(aws elbv2 describe-target-groups --load-balancer-arn "$lb_arn" | jq -r ".TargetGroups[].TargetGroupArn")
#echo "Identified LB target groups:"
#echo "$groups"
#echo "Identifying LB target groups with 0 targets:"
for group in $groups; do
    len=$(aws elbv2 describe-target-health --target-group-arn "$group" | jq ".TargetHealthDescriptions|length");
    if [ $len -eq 0 ]; then
        echo "$group";
    fi
done
