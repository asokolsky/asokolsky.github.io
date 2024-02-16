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