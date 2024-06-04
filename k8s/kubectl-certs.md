# k8s and Certificates

Generate CSR [as described](../apps/openssl/).

Show CSRs
```sh
kubectl get csr
```

Or to view the details:
```sh
kubectl get csr jane -o=yaml
```

Approve it:

```sh
kubectl certificate approve jane
```

Alternatively:
```sh
kubectl certificate deny agent-smith
```