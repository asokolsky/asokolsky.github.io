# Handling K8s secrets in `kubectl`

Retrieving secrets:
```
> kubectl get secrets -n foo
NAME                  TYPE     DATA   AGE
bar        Opaque   2      22d
baz        Opaque   1      10d
```

## Describe secret

```
> kubectl describe secret foo -n foo-namespace
Name:         foo
Namespace:    foo-namespace
Labels:       <none>
Annotations:  <none>

Type:  Opaque

Data
====
api-key:  32 bytes
app-key:  40 bytes
```

## Retrieve secret values

Retrieve and decode the binary secret:
```sh
kubectl get secret <secret-name> -n <namespace> -o jsonpath='{.data.<key>}' |\
    base64 --decode
```

Example:
```
> kubectl get secret foo -n foo-namespace -o jsonpath='{.data}'
{"api-key":"fffooooo=","app-key":"bbbaaar=="}
```

## Create secret

Store it:
```sh
kubectl create secret generic foo -n foo-namespace \
    --from-literal=api-key="ffffoooo=" \
    --from-literal=app-key="bbbbaaar=="
```
## Editing secret

```sh
kubectl edit secrets <secret-name>
```
