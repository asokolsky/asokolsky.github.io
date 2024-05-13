## Helm

Helm is the Kubernetes package manager.
[Installation instructions](https://helm.sh/docs/intro/install/)

Command|Description
----|------
`helm install <name> <chart>`|Install a chart with a name
`helm install <name> <chart> --namespace <namespace>`|Install a chart in a specific namespace
`helm list`|List releases
`helm uninstall <name>`|Uninstall a release
`helm upgrade <name> <chart>`|Upgrade a release
