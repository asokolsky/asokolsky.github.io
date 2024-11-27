# AWS DynamoDB CLI

[reference](https://docs.aws.amazon.com/cli/latest/reference/dynamodb/)

## help

```sh
aws dynamodb help
```

# describe-table

```sh
aws dynamodb describe-table --table-name table-name
```

## get-item

[reference](https://docs.aws.amazon.com/cli/latest/reference/dynamodb/get-item.html)
```
> aws dynamodb get-item --table-name image-versions \
    --key '{"image":{"S":"docker.io/alex/test/dev"}}'
{
    "Item": {
        "image": {
            "S": "docker.io/alex/test/dev"
        },
        "version": {
            "S": "6b42316197"
        }
    }
}
```

## query

[reference](https://docs.aws.amazon.com/cli/latest/reference/dynamodb/query.html)


## scan

[reference](https://docs.aws.amazon.com/cli/latest/reference/dynamodb/scan.html)

```sh
aws dynamodb scan --table-name image-versions
```
