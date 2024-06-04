# base64 cli

[man base64](https://linux.die.net/man/1/base64)

## Encode

```sh
echo -n 'Hello, World!' | base64
```

This will give `SGVsbG8sIFdvcmxkIQ==`.

Use of [here-string](https://www.baeldung.com/linux/heredoc-herestring) to
provide the input will append a newline:

```
$ base64 <<< 'Hello, World!'
SGVsbG8sIFdvcmxkIQo=
```

## Decode

You can use echo or here-doc to provide the input:

```
$ base64 -d <<< SGVsbG8sIFdvcmxkIQo=
Hello, World!
```
