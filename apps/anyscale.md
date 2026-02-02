# Anyscale

https://console.anyscale.com/v2/abcdefg

## CLI install

```sh
pip install anyscale
```

then:
```sh
anyscale login
```
which creates `~/.anyscale/credentials.json` to expire in 7 days.

then:
```sh
anyscale workspace_v2 ssh --id expwrk_wr1234567890
```
