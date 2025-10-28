# keybase.io

"End-to-end encryption for things that matter."

## Set-up

### Install an application

On Mac:

```sh
brew install keybase
```

### Create an account on keybase.io

Just follow the steps

### Generate a pgp key

```sh
keybase pgp gen
```

## Using it

By now you have a pgp key available for your use:

```
asokolsky in ~/ > keybase pgp list
Keybase Key ID:  01015b1e9f7ecfb69136aabb60b29528343e4acb84698d7a39d2d587901f6f6238de0a
PGP Fingerprint: 721edb24fe215bf949e5b960a849309a9f8f285f
PGP Identities:
   Alex Sokolsky <asokolsky@company.com>
```

Given a password encrypted with your pgp key
```sh
password="wcFMAy9....tCtzshbbYDmKVMHmNl"
```
decrypt it using keybase:
```sh
echo $password | base64 --decode | keybase pgp decrypt
```
