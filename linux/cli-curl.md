# curl

* [man page](https://man7.org/linux/man-pages/man1/curl.1.html)
* [repo](https://github.com/curl/curl/)
* [smb section in the manual](https://github.com/curl/curl/blob/master/docs/MANUAL.md#smb--smbs)
* [tutorial](https://curl.se/docs/tutorial.html)

## Common Options

`-#, --progress-bar` Make curl display a simple progress bar instead of the more
informational standard meter.

`-b, --cookie <name=data>` Supply cookie with request. If no `=`, then specifies
the cookie file to use (see `-c`).

`-c, --cookie-jar <file name>` File to save response cookies to.

`-d, --data <data>` Send specified data in POST request, makes `-X POST`
redundant.

`-f, --fail` Fail silently (don't output HTML error form if returned).

`-F, --form <name=content>` Submit form data.

`-H, --header <header>` Headers to supply with request.

`-i, --include` Include HTTP headers in the output.

`-I, --head` Fetch headers only.

`-k, --insecure` Allow insecure connections to succeed.

`-L, --location` Follow redirects.

`-o, --output <file>` Write output to <file>. Can use `--create-dirs` in
conjunction with this to create any directories specified in the `-o` path.

`-O, --remote-name` Write output to file named like the remote file
(only writes to current directory).

`-s, --silent` Silent (quiet) mode. Use with `-S` to force it to show errors.

`-T, --upload-file <file>` transfers the specified local file to the remote URL.

`-v, --verbose` Provide more information (useful for debugging).

`-w, --write-out <format>` Make curl display information on stdout after a
completed transfer. See man page for more details on available variables.
Convenient way to force curl to append a newline to output: `-w "\n"`
(can add to `~/.curlrc`).

`-X, --request` The request method to use.

## http post / put

Specify the request type:

 * `-X POST` - is assumed and can be omitted
 * `-X PUT`

Sspecify the `Content-Type` header as one of:

  * `-H "Content-Type: application/x-www-form-urlencoded"`
  * `-H "Content-Type: application/json"`

Add the corresponding payload:

  * `-d "param1=value1&param2=value2"` or `-d @data.txt`
  * `-d '{"key1":"value1", "key2":"value2"}'` or `-d @data.json`

File `data.txt`:
```
param1=value1&param2=value2
```

File `data.json`:
```json
{
  "key1":"value1",
  "key2":"value2"
}
```

## Examples

### http post application/x-www-form-urlencoded

`application/x-www-form-urlencoded` is the default, `-X POST` implied when `-d`
is used:

```sh
curl -d "param1=value1&param2=value2" http://localhost:3000/data
```
explicit:

```sh
curl -d "param1=value1&param2=value2" \
    -H "Content-Type: application/x-www-form-urlencoded" \
    http://localhost:3000/data
```
with a data file

```sh
curl -d "@data.txt" http://localhost:3000/data
```

### http post application/json

```sh
curl -d '{"key1":"value1", "key2":"value2"}' \
    -H "Content-Type: application/json" \
    http://localhost:3000/data
```

with a data file

```sh
curl -d "@data.json" http://localhost:3000/data
```

### smb

Given that curl only supports SMB protocol version 1, the following is pretty
much useless.

Download a file from the SMB server:
```sh
curl -u "domain\username:passwd" smb://server.example.com/share/file.txt
```

Upload a file to the SMB server:
```sh
curl -T file.txt -u "domain\username:passwd" smb://server.example.com/share/
```

### ssh

Get a file from an SSH server using SCP using a (not password-protected) private
key to authenticate:

```sh
curl -u username: --key ~/.ssh/id_rsa scp://example.com/~/file.txt
```

Get a file from an SSH server using SCP using a (password-protected) private key
to authenticate:

```sh
curl -u username: --key ~/.ssh/id_rsa --pass private_key_password \
    scp://example.com/~/file.txt
```
