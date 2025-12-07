# AWS Resource Explorer CLI

Get the total count of untagged objects:

```sh
aws resource-explorer-2 search --query-string="tag:none" --no-paginate | jq ".Count.TotalResources"
```

Get the count of objects with any tag
```sh
aws resource-explorer-2 search --query-string="tag:all" --no-paginate | jq ".Count.TotalResources"
```
