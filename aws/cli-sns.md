# AWS Simple Notification Service (SNS) CLI

[AWS SNS is a messaging service](https://docs.aws.amazon.com/sns/latest/dg/welcome.html) that enables applications, end-users, and devices to send and receive notifications.

[Accessing Amazon SNS in the AWS CLI](https://docs.aws.amazon.com/cli/v1/userguide/cli-services-sns.html).

## One Way of accessing SNS messages via CLI

Create an SQS queue:
```sh
aws sqs create-queue --queue-name MySNSQueue
```

Subscribe the SQS queue to your SNS topic:
```sh
aws sns subscribe --topic-arn arn:aws:sns:us-west-2:123456789012:my-topic \
    --protocol sqs \
    --notification-endpoint arn:aws:sqs:us-west-2:123456789012:MySNSQueue
```

The above returns subscription arn you can use to unsubscribe:
```sh
aws sns unsubscribe --subscription-arn arn:aws:sns:us-west-2:123456789012:my-topic:1328f057-de93-4c15-512e-8bb22EXAMPLE
```

Receive messages from the SQS queue:
```sh
aws sqs receive-message --queue-url https://sqs.REGION.amazonaws.
```

## Create/Delete a topic

```sh
aws sns create-topic --name my-topic
```

```sh
aws sns delete-topic --topic-arn arn:aws:sns:us-west-2:123456789012:my-topic
```

## Publish to a topic

```sh
aws sns publish --topic-arn arn:aws:sns:us-west-2:123456789012:my-topic \
    --message "Hello World!"
```

## Listing topics and subscriptions

List topics:
```sh
aws sns list-topics
```

List subscriptions:
```sh
aws sns list-subscriptions
```
