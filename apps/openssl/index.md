# openssl

## Create a Key

```sh
openssl genrsa --out jane.key 2048
```

## Create a Cert Request

```sh
openssl erq -new -key jane.key -subj "/CN=jane" -out jane.csr
```
