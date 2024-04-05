# wget in place of curl

Many containers pack `wget` but not `curl`.  In this case, replace a call to
`curl` with:

```sh
wget -qO - _url_
```
