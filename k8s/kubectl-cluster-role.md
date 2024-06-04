# kubectl Cluster Role, Cluster Role Binding

[kubectl_create_clusterrole](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_create/kubectl_create_clusterrole/),
[kubectl_create_clusterrolebinding](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_create/kubectl_create_clusterrolebinding/)

Cluster roles are cluster-wide and are NOT part of any namespace.
Use:
```sh
k api-resources
```
to get short names, etc.


## Practical Example

A new user michelle joined the team. She will be focusing on the nodes in the
cluster. Create the required ClusterRoles and ClusterRoleBindings so she gets
access to the nodes.

Create a ClusterRole:
```sh
k create clusterrole node-access --verb=get,list,watch --resource=node
```

More verbs: `create`

Create a ClusterRoleBinding:
```sh
k create clusterrolebinding node-access --clusterrole=node-access --user=michelle
```

To verify:
```sh
k get nodes --as michelle
```
