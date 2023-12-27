# Vault in a Container

Created LXC using Proxmox GUI using the latest debian image.

[Setup Hashicorp Vault Using Ansible](https://medium.com/@mitesh_shamra/setup-hashicorp-vault-using-ansible-fa8073a70a56)

## Installation

```sh
apt update
apt upgrade
```

Then followed https://developer.hashicorp.com/vault/tutorials/getting-started/getting-started-install

Install pre-requisites (updated!):
```sh
apt install sudo gpg lsb-release
```

Install Hashi keyring:
```sh
wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | tee /usr/share/keyrings/hashicorp-archive-keyring.gpg >/dev/null
```

Verify the fingerprint:
```sh
gpg --no-default-keyring --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg --fingerprint
```

Add the official HashiCorp Linux repo:
```sh
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
```

Finally:
```sh
apt update
apt install vault
```

To verify install: `vault`

## Configuration

Followed https://developer.hashicorp.com/vault/tutorials/getting-started/getting-started-deploy

```
root@vault:/etc/vault.d# ls -la
total 12
drwxr-xr-x  2 vault vault 4096 Nov 25 18:33 .
drwxr-xr-x 65 root  root  4096 Nov 25 18:33 ..
-rw-r--r--  1 vault vault    0 Oct 27 19:33 vault.env
-rw-r--r--  1 vault vault  975 Oct 27 19:33 vault.hcl
```

Note enabling `disable_mlock` and use of HTTP listener:

```hcl
root@vault:/etc/vault.d# cat vault.hcl
# Full configuration options can be found at https://www.vaultproject.io/docs/configuration

ui = true

#mlock = true
disable_mlock = true

storage "file" {
  path = "/opt/vault/data"
}

# HTTP listener
listener "tcp" {
  address = "0.0.0.0:8200"
  tls_disable = 1
}

# HTTPS listener
#listener "tcp" {
#  address       = "0.0.0.0:8200"
#  tls_cert_file = "/opt/vault/tls/tls.crt"
#  tls_key_file  = "/opt/vault/tls/tls.key"
#}

# Enterprise license_path
# This will be required for enterprise as of v1.8
#license_path = "/etc/vault.d/vault.hclic"

# Example AWS KMS auto unseal
#seal "awskms" {
#  region = "us-east-1"
#  kms_key_id = "REPLACE-ME"
#}

# Example HSM auto unseal
#seal "pkcs11" {
#  lib            = "/usr/vault/lib/libCryptoki2_64.so"
#  slot           = "0"
#  pin            = "AAAA-BBBB-CCCC-DDDD"
#  key_label      = "vault-hsm-key"
#  hmac_key_label = "vault-hsm-hmac-key"
#}
```

Start the server:
```
root@vault:/etc/vault.d# vault server -config=/etc/vault.d/vault.hcl
==> Vault server configuration:

                     Cgo: disabled
              Go Version: go1.19.2
              Listener 1: tcp (addr: "0.0.0.0:8200", cluster address: "0.0.0.0:8201", max_request_duration: "1m30s", max_request_size: "33554432", tls: "disabled")
               Log Level: info
                   Mlock: supported: true, enabled: false
           Recovery Mode: false
                 Storage: file
                 Version: Vault v1.12.1, built 2022-10-27T12:32:05Z
             Version Sha: e34f8a14fb7a88af4640b09f3ddbb5646b946d9c

==> Vault server started! Log data will stream in below:

2022-11-25T19:45:42.830Z [INFO]  proxy environment: http_proxy="" https_proxy="" no_proxy=""
2022-11-25T19:45:42.830Z [WARN]  no `api_addr` value specified in config or in VAULT_API_ADDR; falling back to detection if possible, but this value should be manually set
2022-11-25T19:45:42.831Z [INFO]  core: Initializing version history cache for core
```

In another shell:
```
root@vault:~# export VAULT_ADDR='http://127.0.0.1:8200'
root@vault:~# vault operator init
Unseal Key 1: jOIB9hL/Hjk1RIVvTVN8OOeeR3V2bwKK64rLlnMROxxY
Unseal Key 2: h/OS2vXIP0hdfaB/2IqxUk39oAoaUIwjwJm8zFkvWYFr
Unseal Key 3: k1/BI+b9qQBJxBENCDjtvd7rH1jqdxRWbFKDQlpNBuRn
Unseal Key 4: b2uSpZU/+OiCJPYyJzd0jLRaSCfsLo62Atcd5HlKtDcK
Unseal Key 5: 36qq18wkWr6M6YquumEG5vbozW9bTFCqTwoCHBkiJQkE

Initial Root Token: hvs.xNgu8r5l4PNgp3efUOmu6DTp

Vault initialized with 5 key shares and a key threshold of 3. Please securely
distribute the key shares printed above. When the Vault is re-sealed,
restarted, or stopped, you must supply at least 3 of these keys to unseal it
before it can start servicing requests.

Vault does not store the generated root key. Without at least 3 keys to
reconstruct the root key, Vault will remain permanently sealed!

It is possible to generate new unseal keys, provided you have a quorum of
existing unseal keys shares. See "vault operator rekey" for more information.
```

For suprox:
```
Unseal Key 1: LohsDZtVdTmwvYDyODhyGUgkmrk4OSqG1B2Bpxt3cGbE
Unseal Key 2: XBFYvEoQYMQzNMOADL+AvANV4vyfi12ycv1fURXklzKX
Unseal Key 3: cRiQoSJnECsTt6aKBS8hvsm8/kAIcRzUZ3kgDwZOpecn
Unseal Key 4: 17TEfR5ZS8l/dsjqCIcPW2yEeTI5WaxylWoQWW9PyCke
Unseal Key 5: 3Nhpx0pwzpiI1OKOqvYM2w9C0327eyJGIu+Egbx2l1hP

Initial Root Token: hvs.iNt86WeAqzqUw6AtGmBnoOdo
```

Now point your browser to http://vault:8200/ and

* use 3 of the above keys to unseal the vault
* sign in to Vault


And

```
root@vault:~# vault status
Key             Value
---             -----
Seal Type       shamir
Initialized     true
Sealed          false
Total Shares    5
Threshold       3
Version         1.12.1
Build Date      2022-10-27T12:32:05Z
Storage Type    file
Cluster Name    vault-cluster-0a79465b
Cluster ID      25e8101e-8489-de59-047c-d70440b42a0a
HA Enabled      false
```

## Vault as a service

```
cat <<EOF | sudo tee /etc/systemd/system/vault.service
{% include_relative vault.service %}
EOF
```

```
systemctl status -l vault
* vault.service - "HashiCorp Vault - A tool for managing secrets"
     Loaded: loaded (/lib/systemd/system/vault.service; disabled; vendor preset: enabled)
     Active: activating (start) since Thu 2023-12-14 03:08:08 UTC; 1min 4s ago
       Docs: https://developer.hashicorp.com/vault/docs
   Main PID: 544 (vault)
      Tasks: 6 (limit: 38261)
     Memory: 22.4M
        CPU: 108ms
     CGroup: /system.slice/vault.service
             `-544 /usr/bin/vault server -config=/etc/vault.d/vault.hcl
```
