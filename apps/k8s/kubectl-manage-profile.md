# kubectl - managing profiles


## Prerequisites

Setup [aws-vault](/aws/aws-vault.html), create profile(s), e.g.
`dev-from-security`.

## Create the kubeconfig files per account

```sh
aws-vault exec dev-from-security -- aws eks update-kubeconfig --region us-east-1 --name test --kubeconfig $HOME/.kube/dev-config
```

## Autopick the right kubeconfig

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
