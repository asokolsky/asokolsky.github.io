# AWS Simple Queue Service (SQS) CLI

Save the FIFO URL:
```sh
export QUEUE_URL=https://sqs.us-east-1.amazonaws.com/123456/fivetran-clari-labs-nlb-rds-target-update-lambda.fifo
```

```sh
aws sqs get-queue-attributes --queue-url $QUEUE_URL --output json
aws sqs tag-queue --queue-url $QUEUE_URL --output json --tags Managed=manually
aws sqs list-queue-tags --queue-url $QUEUE_URL --output json
aws sqs untag-queue --queue-url $QUEUE_URL --output json --tag-keys Managed
aws sqs list-queue-tags --queue-url $QUEUE_URL --output json
aws sqs send-message --queue-url $QUEUE_URL --output json --message-body "foobar" --delay-seconds 10
aws sqs receive-message --queue-url $QUEUE_URL --attribute-names All --message-attribute-names All --max-number-of-messages 1
```

Create a JSON message in `message.json`:
```json
{
    "version": "0",
    "id": "12a345b6-78c9-01d2-34e5-123f4ghi5j60",
    "detail-type": "RDS DB Instance Event",
    "source": "aws.rds",
    "account": "123456778",
    "time": "2025-08-05T12:36:09Z",
    "region": "us-east-1",
    "resources": [
        "arn:aws:rds:us-east-1:123456778:db:testdb"
    ],
    "detail": {
        "EventCategories": [
            "notification"
        ],
        "SourceType": "DB_INSTANCE",
        "SourceArn": "arn:aws:rds:us-east-1:123456778:db:foo-bar-0",
        "Date": "2025-08-05T12:36:09.293Z",
        "Message": "DB instance restarted.",
        "SourceIdentifier": "foo-bar-0",
        "EventID": "RDS-EVENT-0008"
    }
}

```

Post the JSON message to the SQS FIFO:
```
> aws sqs send-message --queue-url $QUEUE_URL \
  --message-group-id ID --message-deduplication-id DEDUP_ID \
  --message-body file://./message.json
{
    "MD5OfMessageBody": "2e78ebe55160d377085f0da55dd9ed46",
    "MessageId": "28fa9113-bc8a-4104-8ebe-f6c65af6e750",
    "SequenceNumber": "18895874978233583616"
}
```
