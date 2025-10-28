# AWS Lambda CLI

* [docs](https://docs.aws.amazon.com/lambda/latest/dg/gettingstarted-awscli.html)
* [reference](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/lambda/index.html#cli-aws-lambda)

## List Lambdas

[list-functions](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/lambda/list-functions.html)

```sh
aws lambda list-functions --max-items 10
```
or just list function names:

```sh
aws lambda list-functions --query 'Functions[].FunctionName'
```

## Retrieve a Lambda

[get-function](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/lambda/get-function.html)

```sh
aws lambda get-function --function-name my-function
```


## Create Lambda

[create-function](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/lambda/create-function.html)


```sh
aws lambda create-function --function-name my-function \
    --zip-file fileb://function.zip \
    --handler index.handler \
    --runtime nodejs20.x \
    --role arn:aws:iam::123456789012:role/lambda-ex
```

## Update Lambda

```sh
aws lambda update-function-configuration --function-name my-function \
    --memory-size 256
```

## Delete Lambda

```sh
aws lambda delete-function --function-name my-function
```


## Invoke Lambda and Get Logs

[invoke](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/lambda/invoke.html)

```sh
aws lambda invoke --function-name my-function out --log-type Tail
```

To decode these:

```sh
aws lambda invoke --function-name my-function out --log-type Tail \
    --query 'LogResult' --output text |  base64 -d
```

Example `get-logs.sh`:

```
#!/bin/bash
aws lambda invoke --function-name my-function --cli-binary-format raw-in-base64-out --payload '{"key": "value"}' out
sed -i'' -e 's/"//g' out
sleep 15
aws logs get-log-events --log-group-name /aws/lambda/my-function --log-stream-name $(cat out) --limit 5
```

## Limitations

https://docs.aws.amazon.com/lambda/latest/dg/gettingstarted-limits.html

Execution & Performance:

* Maximum Runtime: a hard limit of 15 minutes (900 seconds) for execution.
* Memory & CPU: RAM from 128 MB to 10 GB, with higher allocations increasing CPU power and network bandwidth.
* Cold Starts: due to the on-demand nature, new function instances can experience "cold starts," which are initialization times that introduce latency.
* No Checkpointing: Lambda does not support native checkpointing, making it difficult to save progress and resume long-running processes.

Deployment & Size:

* Deployment Package Size: The compressed (.zip) deployment package size has a limit of 50 MB.
* Uncompressed Size: Once uncompressed, the deployment package (including code and dependencies) must not exceed 250 MB.
* Container Image Size: For container images, there is a maximum size of 10 GB.

Concurrency & Scaling Limits

* Account Concurrency: by default, a region has a concurrency limit of 1,000 concurrent executions for your account across all functions.
* Event Source Concurrency: Specific event source mappings, such as those for Amazon MQ, may have their own lower concurrency limits.

Others:

* No State Management: lambda functions are stateless; they cannot share data between invocations. State should be stored in external services like Amazon DynamoDB or AWS RDS.
* Observability: logging in to servers is not possible, which can make observability and debugging more challenging.
* Vendor Lock-in: tight integration with other AWS services can lead to vendor lock-in, requiring a shift in architecture for those accustomed to traditional systems.
* Long-Running Processes: due to the execution and state limitations, Lambda is generally not suitable for long-running, stateful processes.
