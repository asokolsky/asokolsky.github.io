# # AWS Resource Explorer CLI

total count of untagged objects:

```sh
aws resource-explorer-2 search --query-string="tag:none" --no-paginate | jq ".Count.TotalResources"
```

count of objects with any tag
```sh
aws resource-explorer-2 search --query-string="tag:all" --no-paginate | jq ".Count.TotalResources"
```
