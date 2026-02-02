# Backing up k8s cluster

Use [Velero](https://velero.io/docs/):

* [How Velero Works](https://velero.io/docs/v1.13/how-velero-works/).

## Listing Backups

```sh
kubectl get backup --all-namespaces --show-labels=true
```

## On Demand Backup

Identify velera pod:
```sh
kubectl get pod -n velero
```

Start the backup by passing the velero command to the pod:
```sh
kubectl exec -it velero-7f8d8d6bf9-86v9c --container velero -n velero \
    -- /velero backup create vault-backup --include-namespaces vault
```

To see the details of the created backup:
```sh
kubectl exec -it velero-7f8d8d6bf9-86v9c --container velero -n velero \
    -- /velero backup describe vault-backup
```

## Backup Verification - Restore Backup to a Different Namespace

To avoid the need to shutdown vault to test the backup, you can verify the backup by restoring it to a different namespace, e.g. `vault1`.

### Before you attempt to restore

A simple attempt to restore into a different namespace will fail, because this new namespace does not have the service account for vault to use.

Begin with creating the new namespace, target for the restore:
```sh
kubectl apply -f - <<EOF
apiVersion: v1
kind: Namespace
metadata:
  labels:
    istio.io/dataplane-mode: ambient
    kustomize.toolkit.fluxcd.io/prune: disabled
    name: vault1
  name: vault1
EOF
```

Prepare `trust-policy.json` (Attention: cluster-specific, so you will need to edit it!) for the new namespace `vault1`:
```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::123456789:oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/E7281548B3E48DB5B68C580B64F46EC1"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "oidc.eks.us-east-1.amazonaws.com/id/E7281548B3E48DB5B68C580B64F46EC1:sub": "system:serviceaccount:vault1:vault"
        }
      }
    }
  ]
}
```

Create a role for the new service account to use and attach the trust policy to it:
```sh
aws iam create-role --role-name test-vault1-kms-unseal --assume-role-policy-document file://trust-policy.json
```
Attach the existing (cluster-specific!) policy to the newly created role:
```sh
aws iam attach-role-policy --role-name test-vault1-kms-unseal \
    --policy-arn arn:aws:iam::123456789:policy/test-vault-kms-unseal-20231003173000386500000001
```

Create a new service account `vault` in the newly created namespace `vault1` and associate it with a newly created role:
```sh
kubectl apply -f - <<EOF
apiVersion: v1
kind: ServiceAccount
metadata:
  annotations:
    eks.amazonaws.com/role-arn: arn:aws:iam::123456789:role/test-vault1-kms-unseal
  name: vault
  namespace: vault1
EOF
```

Create a secret required for vault OIDC login.  Pull the secret from: Okta Admin Dashboard -> Applications -> Applications -> Vault - <Environment> -> General -> Client ID
```sh
kubectl apply -f - <<EOF
apiVersion: v1
kind: Secret
metadata:
  name: okta-oidc
  namespace: vault1
stringData:
  OKTA_OIDC_CLIENT_SECRET: <VALUE_FROM_OKTA>
EOF
```

### Restore the backup into a new namespace

```sh
velero restore create test-restore  --from-backup vault-20250327010027 --namespace-mappings vault:vault1
```

### Verification

There should be no errors in velero logs:
```sh
kubectl logs deployment/velero -n velero
```
or
```sh
velero restore logs test-restore
```

Verify that the namespace `vault1` is restored and is active:
```sh
kubectl get namespace vault1
```

### Cleanup

Delete the restore:
```sh
velero restore delete test-restore
```
Clean the namespace `vault1`:
```sh
kubectl delete namespaces vault1
```
Delete the role you created
```sh
aws iam detach-role-policy --role-name test-vault1-kms-unseal \
    --policy-arn arn:aws:iam::123456789:policy/test-vault-kms-unseal-20231003173000386500000001
aws iam delete-role --role-name test-vault1-kms-unseal
```
## Restore from a Backup

Follow [these steps](https://cray-hpe.github.io/docs-csm/en-10/operations/security_and_authentication/backup_and_restore_vault_clusters/).

### Verify the backup

```sh
velero describe backup <name> --details
```

### Prepare for the Vault shutdown

Scale down the Vault configurer:
```sh
kubectl -n vault scale deployment vault-configurer --replicas=0
```

Verify that the scale down actually happened with:
```sh
kubectl -n vault get deployment
```
Expected output:

Delete the Vault instance.  This is done to minimize the risk of Vault being in a partially restored state.  Vault will be inaccessible (if not already) after running the following commands.

```sh
kubectl -n vault delete vault
kubectl -n vault delete pvc
kubectl -n vault delete secret
```

Finally, wipe the namespace clean:
```sh
kubectl delete namespaces vault
```

### Restore from the existing backup

Pass `velero restore create --from-backup vault-20240111010024` to the velero pod:
```sh
kubectl exec -it velero-6c474ffbb-xg8ht -n velero \
    -- /velero restore create --from-backup vault-20240112010005
```

### Re-initialize vault Namespace

Now that the namespace is deleted, re-initialize it:
```sh
flux resume kustomization vault
flux reconcile kustomization vault
```

### Create the vault secret

Create a manual secret required for vault OIDC login.

You can pull the secret from:
Okta Admin -> Applications -> Applications -> Vault - <Environment> -> General -> Client Secret

```sh
kubectl apply -f - <<EOF
apiVersion: v1
kind: Secret
metadata:
  name: okta-oidc
  namespace: vault
stringData:
  OKTA_OIDC_CLIENT_SECRET: <VALUE_FROM_OKTA>
EOF
```

### Scale the Vault configurer back to one replica

```sh
kubectl -n vault scale deployment vault-configurer --replicas=1
```

### Verify that the changes were successfully made

```sh
kubectl -n vault get deployment
```

### If necessary, delete the Vault pods and allow the configurer to restart them

If the Vault statefulset pods are in CrashLoopBackOff after 5-10 minutes of performing the restore operation, then the pods need to be manually restarted.

The Vault statefulset pods normally go through a number of restarts on a clean start-up.

Check that the pods are in a CrashLoopBackOff state:

```sh
kubectl -n vault get pod -o wide
```

Delete the pods to restart them:

```sh
kubectl delete pod -n vault
```

Finally, verify that all the pods are in a Running state.
```sh
kubectl get pod -n vault
```
Expected output:
```
NAME                                    READY   STATUS    RESTARTS      AGE
vault-0                                 4/4     Running   0             19m
vault-1                                 4/4     Running   0             17m
vault-2                                 4/4     Running   1 (18m ago)   18m
vault-configurer-7f7b996c95-h4lxz       1/1     Running   0             28m
vault-csi-provider-csi-provider-k2l87   2/2     Running   5 (25m ago)   28m
vault-csi-provider-csi-provider-mg2ll   2/2     Running   5 (25m ago)   28m
vault-csi-provider-csi-provider-nf7m7   2/2     Running   0             26m
```
