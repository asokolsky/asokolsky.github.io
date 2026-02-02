# AWS Elastic Kubernetes Service (EKS)

[reference](https://docs.aws.amazon.com/cli/latest/reference/eks/)

The bellow commands take `--profile` or `AWS_PROFILE`.

List the k8s clusters in this account:
```sh
aws eks list-clusters
```

Get cluster's k8s version:
```sh
aws eks describe-cluster --name _cluster_name_ --query 'cluster.version'
```

Retrieve `kubeconfig`:
```sh
aws eks update-kubeconfig --name _cluster-name_  --alias _alias_
```
