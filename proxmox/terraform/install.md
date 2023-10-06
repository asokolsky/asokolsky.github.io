# Start Using Terraform on a Proxmox Server

## Install

From
[tutorial](https://learn.hashicorp.com/tutorials/terraform/install-cli):


```sh
apt -y install lsb-release software-properties-common
```

Add the HashiCorp GPG key:

```sh
curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add -
```

Add the repo:
```sh
apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
```

Install Terraform:
```sh
apt update && apt install -y terraform
```

## Use API-keys for Authentication

1. Create a datacenter user. In the Datacenter/Permissions/User add,
e.g. `alex`, realm: Linux PAM.

2. Verify in Proxmox console using `pveum user list`

3. Create a new API token. In the Datacenter/Permissions/API Tokens, add:

* user: `alex@pam`
* token id: `new_token_id`
* privilege separation:  unchecked
* Secret fuji: `ebf02232-ec86-480c-acdf-4e83fed2c2e6`
* Secret suprox: `edf8b941-c633-48f2-bc70-9bf5dea85668`

4. add a role `PVEAdmin` to the newly created user `alex`:
`pveum acl modify  / --roles PVEAdmin --users alex@pam`

* user permission - Path=/storage/local-lvm, User=asokolsky@pam, Role=Administrator,
Propagate=true

## Terraform Basic Info and Provider Installation

```console
root@duo:~/terraform# pwd
/root/terraform
root@duo:~/terraform# ls -la
total 12
drwxr-xr-x 2 root root 4096 Oct 22 15:10 .
drwx------ 9 root root 4096 Oct 22 14:56 ..
-rw-r--r-- 1 root root  120 Oct 22 14:57 main.tf
-rw-r--r-- 1 root root    0 Oct 22 14:56 vars.tf
root@duo:~/terraform# cat main.tf
terraform {
  required_providers {
    proxmox = {
      source = "telmate/proxmox"
      version = "2.7.4"
    }
  }
}
root@duo:~/terraform# terraform init

Initializing the backend...

Initializing provider plugins...
- Finding telmate/proxmox versions matching "2.7.4"...
- Installing telmate/proxmox v2.7.4...
- Installed telmate/proxmox v2.7.4 (self-signed, key ID A9EBBE091B35AFCE)

Partner and community providers are signed by their developers.
If you'd like to know more about provider signing, you can read about it here:
https://www.terraform.io/docs/cli/plugins/signing.html

Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```
