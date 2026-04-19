# AWS Elastic Container Services (ECS) CLI

[reference](https://docs.aws.amazon.com/cli/latest/reference/ecs/)

## List tasks

[List tasks](https://docs.aws.amazon.com/cli/latest/reference/ecs/list-tasks.html) and their arn's:

```sh
aws ecs list-tasks --cluster FOO --service-name BAR
```

[Execute-command](https://docs.aws.amazon.com/cli/latest/reference/ecs/execute-command.html) in the container:

```sh
aws ecs execute-command --cluster FOO --container CONTAINER --task TASK \
  --interactive --command "/bin/bash"
```
