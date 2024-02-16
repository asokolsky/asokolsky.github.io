# AWS Resource Access Manager (RAM) CLI

[reference](https://docs.aws.amazon.com/cli/latest/reference/ram/)


## List Resources

[List resources](https://docs.aws.amazon.com/cli/latest/reference/ram/list-resources.html):

```sh
aws ram list-resources --resource-owner SELF
```

```sh
aws ram list-resources --resource-owner OTHER-ACCOUNTS
```

## Delete resource share

[Delete resource share](https://docs.aws.amazon.com/cli/latest/reference/ram/delete-resource-share.html):

```sh
aws ram delete-resource-share --resource-share-arn _arn_
```
