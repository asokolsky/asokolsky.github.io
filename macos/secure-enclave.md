# Using MacOS Secure Enclave with ssh

Sources:

- [The Secure Enclave](https://support.apple.com/guide/security/the-secure-enclave-sec59b0b31ff/web)
- [Native Secure Enclave backed ssh keys on MacOS](https://gist.github.com/arianvp/5f59f1783e3eaf1a2d4cd8e952bb4acf)
- [Laptops all have built-in security tokens these days](https://ahelwer.ca/post/2026-05-08-builtin-u2f/)
- [man sc_auth](https://www.manpagez.com/man/8/sc_auth/osx-10.12.6.php)

Goal: generate and use secure-enclave backed SSH key.

# Key Setup

Create a Secure Enclave backed key that requires touch-key verification:

```sh
sc_auth create-ctk-identity -l ssh -k p-256-ne -t bio
```

Show the key (note the key is valid for 1 year by default):

```sh
sc_auth  list-ctk-identities
```

To delete the key:

```sh
sc_auth delete-ctk-identity -h <Public Key Hash>
```

## Use in ssh

### Bad Idea: copy the key to your HD

Retrieve the keys from the secure enclave:

```sh
ssh-keygen -w /usr/lib/ssh-keychain.dylib -K -N ""
```

This creates `id_ecdsa_sk_rk` and `id_ecdsa_sk_rk.pub`.
Move these into `~/.ssh`.

But, wait, why would you want to store these outside the secure enclave? Delete these from your file system ASAP! You CAN spread the `id_ecdsa_sk_rk.pub` around though.

### Better Idea: feed the key from the secure enclave to ssh-agent

Add a key from the enclave to ssh-agent:

```sh
ssh-add -K -S /usr/lib/ssh-keychain.dylib
```

To list all the keys:

```sh
ssh-add -L
```
