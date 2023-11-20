# kubectl - managing profiles

Thanks to [@shmanubhav](https://github.com/shmanubhav):

1. Save your `~/.kube/config`
2. Create a new `~/.kube/config`, e.g. with
`aws eks update-kubeconfig --region us-east-1 --name test`, replace region
and name as needed.
3. `mv ~/.kube/config ~/.kube/dev-config`
4. `export KUBECONFIG=~/.kube/dev-config`
5. Verify that it worked: `kubectl get nodes`
6. Use `k9s`


## Prerequisites

Setup [aws-vault](/aws/aws-vault.html), create profile(s), e.g.
`dev-from-security`.

## Create the kubeconfig files per account

```sh
aws-vault exec dev-from-security -- aws eks update-kubeconfig --region us-east-1 --name test --kubeconfig $HOME/.kube/dev-config
```

## Autopick the right kubeconfig

Add this to your `.zshenv`
```bash
case "$AWS_VAULT" in
	"dev-from-security" )
		export KUBECONFIG="$HOME/.kube/dev-config" ;;
	*)
		export KUBECONFIG="$HOME/.kube/config" ;;
esac
```


## Use it

Login into your AWS IAM account:
```sh
aws-vault exec --duration=12h dev-from-security
```

A sub-shell is created with `AWS*` and `KUBECONFIG` env variables set.
