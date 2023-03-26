# jq

[Repo](https://github.com/stedolan/jq)

[Manual](https://stedolan.github.io/jq/manual/)

https://www.linode.com/docs/guides/using-jq-to-process-json-on-the-command-line/

## Pretty print

Just pipe it

```sh
terraform show -json|jq
```

Or to pretty print file:

```sh
jq '.' menu.json
```

## Filtering

To access a particular property within a JSON record, use the `.field` operator:

```sh
terraform show -json|jq '.values.root_module.child_modules'
```

To view a specific entry within an array, specify the index of the item within
the `[]` operator:

```sh
terraform show -json|jq '.values.root_module.child_modules[0]'
```

To access an array nested deeper within a JSON file, first use the field
operator to extract the array object. Pipe the result to the [] operator:

```
jq '.values.root_module.child_modules[0].resources|.[].values.private_key_pem' tt1.json
null
null
null
null
null
"-----BEGIN RSA PRIVATE KEY-----\nMIIJK...\n-----END RSA PRIVATE KEY-----\n"
```

To get the last element of the array use index -1:

```sh
jq '.values.root_module.child_modules[0].resources[-1].values.private_key_pem' tt1.json
```

You can also “slice” the array to show only a portion of it:
`[first:last]`.  The first is inclusive, while the last is exclusive.
E.g. to display the first two items of an array, use `[0:2]`.

## Sorting

Simple sort by key:

```sh
jq --sort-keys < foo.json
```

Extract container environment and sort it.
```sh
sudo docker inspect cc43cbfa4153|jq ".[0].Config.Env|sort[]"
```
