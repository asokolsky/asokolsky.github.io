# Hashi Corp Vault

[Vault](https://developer.hashicorp.com/vault/docs/what-is-vault);

[Run it in an LXC](/proxmox/lxc-vault.html)

[Playground](https://falcosuessgott.github.io/hashicorp-vault-playground/home/)

## Client Install and Config

In MacOS:
```
brew tap hashicorp/tap
brew install hashicorp/tap/vault
brew install hudochenkov/sshpass/sshpass
```

Verify success by logging into vault using CLI:
```
export VAULT_ADDR=https://vault.foo.io
vault login -method okta username=asokolsky@foo.com
```

Add to your `~/.zshrc`:

```sh
export VAULT_ADDR=https://vault.foo.io
alias ssh-amc="sshpass -f <(vault write ssh/creds/ssh-admin ip=10.1.254.202 username=ubuntu | grep -w key | awk '{print \$NF}') ssh ubuntu@amc"
```

## Use

Now you can use `ssh-amc` to login to amc.
