# Design Best Practices

[Other best practices](best-practices.html)

## Design Patterns

Learn these, study these, love these.

## Mind Your Complexity

Programming complexity can be reduced if you follow these rules of thumbs:

Complex:
```
foo --calls--> bar --calls--> baz
```
Simple:
```
foo --calls--> bar
foo --calls--> baz
```

## Payload Format

[Comparison of data serialization formats](https://en.wikipedia.org/wiki/Comparison_of_data-serialization_formats).

On the wire use any one of:
* [JSON](https://en.wikipedia.org/wiki/JSON);
* [BSON](https://en.wikipedia.org/wiki/BSON);
* [Protocol Buffers](https://en.wikipedia.org/wiki/Protocol_Buffers).

Do not use [XML](https://en.wikipedia.org/wiki/XML).

## Configuration Storage

The way we store configuration is subject to fashion and is heavily influenced
by the operating environment and/or cloud provider.  Here are some reasonable
candidates:

* [.ini](https://en.wikipedia.org/wiki/INI_file) and
[.toml](https://en.wikipedia.org/wiki/TOML)
* [.yaml](https://en.wikipedia.org/wiki/YAML)

JSON is barely suitable - use YAML instead.

## Secrets - Storage and Passing

Secrets should not be hitting the disk or passed on the command line.
You CAN pass secrets via environment variables.  Better yet
`stdin` or a cloud provider's API.

Store these in the cloud.  Candidates:

* [vault](https://developer.hashicorp.com/vault/docs/what-is-vault);
* [github repo secrets](https://docs.github.com/en/actions/security-guides/using-secrets-in-github-actions) can be used in github actions.
