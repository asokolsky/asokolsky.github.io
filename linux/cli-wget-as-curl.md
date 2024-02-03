# wget in place of curl

Many containers pack wget but not curl.  In this case:

```sh
wget -qO - _url_
```
