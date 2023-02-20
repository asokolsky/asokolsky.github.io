# gomplate

Somehow searching the
[repo](https://github.com/hairyhenderson/gomplate) works
better for me than reading [documentation](https://docs.gomplate.ca/).

## Install

https://docs.gomplate.ca/installing/#manual-install

```sh
sudo curl -o /usr/local/bin/gomplate -sSL https://github.com/hairyhenderson/gomplate/releases/download/v3.11.3/gomplate_linux-amd64
sudo chmod 755 /usr/local/bin/gomplate
```

## Simple use with a (JSON) file data source

[using-file-datasources](https://github.com/hairyhenderson/gomplate/blob/main/docs/content/datasources.md#using-file-datasources)

## Use with AWS Secrets Manager

```
echo 'foo={{ (ds "secrets").foo }}' | gomplate -d secrets=aws+sm///pass-secret
```
