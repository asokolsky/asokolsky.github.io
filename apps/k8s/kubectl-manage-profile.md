# kubectl - managing profiles

## Login

```sh
aws-vault exec --duration=12h shared-from-security
```

A sub-shell created with AWS* env variables set.

`KUBECONFIG` is not set.

## Create a new profile

Login as above into a relevant account.

Verify no clusters attached:
```
> kubectl config get-contexts
CURRENT   NAME   CLUSTER   AUTHINFO   NAMESPACE
```

```sh
export KUBECONFIG=~/.kube/shared-config
```
