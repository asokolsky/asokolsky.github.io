# AWS SQS CLI

```sh

aws sqs get-queue-attributes --queue-url $QUEUE_URL --output json

aws sqs tag-queue --queue-url $QUEUE_URL --output json --tags Managed=manually
aws sqs list-queue-tags --queue-url $QUEUE_URL --output json
aws sqs untag-queue --queue-url $QUEUE_URL --output json --tag-keys Managed
aws sqs list-queue-tags --queue-url $QUEUE_URL --output json

aws sqs send-message --queue-url $QUEUE_URL --output json --message-body "foobar" --delay-seconds 10
aws sqs receive-message --queue-url $QUEUE_URL --attribute-names All --message-attribute-names All --max-number-of-messages 1
```
