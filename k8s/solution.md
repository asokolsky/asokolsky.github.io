# Production k8s Deployment

### atlantis

To avoid the bootstrap circular dependencies, atlantis in shared is installed in infrastructure-live.

Atlantis GUI: https://atlantis-ui.shared.company.io

### blackbox-exporter

The [blackbox-exporter](https://github.com/prometheus/blackbox_exporter/) is used to:

* verify [network connectivity between VPCs](https://docs.google.com/document/d/11uf-HDWwaAlTrUOt4iS2gohezFpREQHH_zR7QQS36Zg/edit#heading=h.oxi7zydw2ax),
both legacy and new world;
* verify presence of atlantis in the shared cluster;
* verify presence of vault in all the new world clusters.


Deploy the blackbox exporter using [helm chart](https://github.com/prometheus-community/helm-charts/tree/main/charts/prometheus-blackbox-exporter).

* repo name: `prometheus-community`, but, given that `-` is not acceptable, make it `prometheus_community`.
* repo URL: https://prometheus-community.github.io/helm-charts
* chart name: `prometheus-blackbox-exporter`
* version: 8.4.0

The latter two derived from the contents of https://prometheus-community.github.io/helm-charts/index.yaml

```
> tk tool charts add-repo prometheus-community https://prometheus-community.github.io/helm-charts
{"level":"info","time":"2023-10-31T12:05:42-07:00","message":"Skipping prometheus-community: invalid name. cannot contain any special characters."}
Error: 1 Repo(s) were skipped. Please check above logs for details
> tk tool charts add-repo prometheus_community https://prometheus-community.github.io/helm-charts
{"level":"info","time":"2023-10-31T12:06:11-07:00","message":"OK: prometheus_community"}
```
Then:
```sh
tk tool charts add prometheus_community/prometheus-blackbox-exporter@8.4.0
```

TODO: blackbox-exporter endpoints are no longer scraped by the datadog.  Start scraping these using splunk, e.g. using [smart agent](https://www.splunk.com/en_us/blog/devops/metrics-from-prometheus-exporters-are-now-available-with-the-sfx-smart-agent.html)

#### Troubleshooting k8s Endpoints

Get a shell in the pod and then:
```sh
wget -qO - http://localhost:9115/metrics|grep prom
```
Check connectivity to shared, example of failure to connect:
```
~ $ wget -qO - http://localhost:9115/probe?target=https://95CD862D2577203EE8607925A3FF3411.gr7.us-east-1.eks.amazonaws.com/livez?verbose
# HELP probe_dns_lookup_time_seconds Returns the time taken for probe dns lookup in seconds
# TYPE probe_dns_lookup_time_seconds gauge
probe_dns_lookup_time_seconds 0.003848593
# HELP probe_duration_seconds Returns how long the probe took to complete in seconds
# TYPE probe_duration_seconds gauge
probe_duration_seconds 5.001584557
# HELP probe_failed_due_to_regex Indicates if probe failed due to regex
# TYPE probe_failed_due_to_regex gauge
probe_failed_due_to_regex 0
# HELP probe_http_content_length Length of http content response
# TYPE probe_http_content_length gauge
probe_http_content_length 0
# HELP probe_http_duration_seconds Duration of http request by phase, summed over all redirects
# TYPE probe_http_duration_seconds gauge
probe_http_duration_seconds{phase="connect"} 0
probe_http_duration_seconds{phase="processing"} 0
probe_http_duration_seconds{phase="resolve"} 0.003848593
probe_http_duration_seconds{phase="tls"} 0
probe_http_duration_seconds{phase="transfer"} 0
# HELP probe_http_redirects The number of redirects
# TYPE probe_http_redirects gauge
probe_http_redirects 0
# HELP probe_http_ssl Indicates if SSL was used for the final redirect
# TYPE probe_http_ssl gauge
probe_http_ssl 0
# HELP probe_http_status_code Response HTTP status code
# TYPE probe_http_status_code gauge
probe_http_status_code 0
# HELP probe_http_uncompressed_body_length Length of uncompressed response body
# TYPE probe_http_uncompressed_body_length gauge
probe_http_uncompressed_body_length 0
# HELP probe_http_version Returns the version of HTTP of the probe response
# TYPE probe_http_version gauge
probe_http_version 0
# HELP probe_ip_addr_hash Specifies the hash of IP address. It's useful to detect if the IP address changes.
# TYPE probe_ip_addr_hash gauge
probe_ip_addr_hash 1.137491e+08
# HELP probe_ip_protocol Specifies whether probe ip protocol is IP4 or IP6
# TYPE probe_ip_protocol gauge
probe_ip_protocol 4
# HELP probe_success Displays whether or not the probe was a success
# TYPE probe_success gauge
probe_success 0
```
Check connectivity to dev, example of success:
```
~ $ wget -qO - http://localhost:9115/probe?target=https://E7281548B3E48DB5B68C580B64F46EC1.sk1.us-east-1.eks.amazonaws.com/livez?verbose
# HELP probe_dns_lookup_time_seconds Returns the time taken for probe dns lookup in seconds
# TYPE probe_dns_lookup_time_seconds gauge
probe_dns_lookup_time_seconds 0.001192028
# HELP probe_duration_seconds Returns how long the probe took to complete in seconds
# TYPE probe_duration_seconds gauge
probe_duration_seconds 0.01042065
# HELP probe_failed_due_to_regex Indicates if probe failed due to regex
# TYPE probe_failed_due_to_regex gauge
probe_failed_due_to_regex 0
# HELP probe_http_content_length Length of http content response
# TYPE probe_http_content_length gauge
probe_http_content_length 1539
# HELP probe_http_duration_seconds Duration of http request by phase, summed over all redirects
# TYPE probe_http_duration_seconds gauge
probe_http_duration_seconds{phase="connect"} 0.000859662
probe_http_duration_seconds{phase="processing"} 0.003866346
probe_http_duration_seconds{phase="resolve"} 0.001192028
probe_http_duration_seconds{phase="tls"} 0.003989397
probe_http_duration_seconds{phase="transfer"} 0.000130071
# HELP probe_http_redirects The number of redirects
# TYPE probe_http_redirects gauge
probe_http_redirects 0
# HELP probe_http_ssl Indicates if SSL was used for the final redirect
# TYPE probe_http_ssl gauge
probe_http_ssl 1
# HELP probe_http_status_code Response HTTP status code
# TYPE probe_http_status_code gauge
probe_http_status_code 200
# HELP probe_http_uncompressed_body_length Length of uncompressed response body
# TYPE probe_http_uncompressed_body_length gauge
probe_http_uncompressed_body_length 1539
# HELP probe_http_version Returns the version of HTTP of the probe response
# TYPE probe_http_version gauge
probe_http_version 2
# HELP probe_ip_addr_hash Specifies the hash of IP address. It's useful to detect if the IP address changes.
# TYPE probe_ip_addr_hash gauge
probe_ip_addr_hash 3.97724711e+09
# HELP probe_ip_protocol Specifies whether probe ip protocol is IP4 or IP6
# TYPE probe_ip_protocol gauge
probe_ip_protocol 4
# HELP probe_ssl_earliest_cert_expiry Returns last SSL chain expiry in unixtime
# TYPE probe_ssl_earliest_cert_expiry gauge
probe_ssl_earliest_cert_expiry 1.729957185e+09
# HELP probe_ssl_last_chain_expiry_timestamp_seconds Returns last SSL chain expiry in timestamp
# TYPE probe_ssl_last_chain_expiry_timestamp_seconds gauge
probe_ssl_last_chain_expiry_timestamp_seconds -6.21355968e+10
# HELP probe_ssl_last_chain_info Contains SSL leaf certificate information
# TYPE probe_ssl_last_chain_info gauge
probe_ssl_last_chain_info{fingerprint_sha256="be495eb2078fe6d04882545c3c79f9d713cc983f3cb75f6784f597ec581e0f2a",issuer="CN=kubernetes",subject="CN=kube-apiserver",subjectalternative="e7281548b3e48db5b68c580b64f46ec1.sk1.us-east-1.eks.amazonaws.com,ip-172-16-107-176.ec2.internal,kubernetes,kubernetes.default,kubernetes.default.svc,kubernetes.default.svc.cluster.local"} 1
# HELP probe_success Displays whether or not the probe was a success
# TYPE probe_success gauge
probe_success 1
# HELP probe_tls_version_info Returns the TLS version used or NaN when unknown
# TYPE probe_tls_version_info gauge
probe_tls_version_info{version="TLS 1.3"} 1
```

#### Vault Endpoints

[Vault health endpoint](https://developer.hashicorp.com/vault/api-docs/system/health)
uses HTTP status code to represent vault state.  To ensure that
`unsealed and standby` is represented by HTTPS status code 200 required by the
blackbox exporter, we use the following customization:

```sh
wget --no-check-certificate -cqSO - https://vault.dev.company.io/v1/sys/health?standbycode=200
```

As you can see, for the standby being false AND true, result in HTTP status 200.

Having established the vault endpoint URL, let's verify that the vault is
healthy in the dev cluster using the blackbox exporter:
```sh
wget -qO - http://localhost:9115/probe?target=https://vault.dev.company.io/v1/sys/health?standbycode=200
```

Produces:
```
# HELP probe_dns_lookup_time_seconds Returns the time taken for probe dns lookup in seconds
# TYPE probe_dns_lookup_time_seconds gauge
probe_dns_lookup_time_seconds 0.003709816
# HELP probe_duration_seconds Returns how long the probe took to complete in seconds
# TYPE probe_duration_seconds gauge
probe_duration_seconds 0.010071418
# HELP probe_failed_due_to_regex Indicates if probe failed due to regex
# TYPE probe_failed_due_to_regex gauge
probe_failed_due_to_regex 0
# HELP probe_http_content_length Length of http content response
# TYPE probe_http_content_length gauge
probe_http_content_length 289
# HELP probe_http_duration_seconds Duration of http request by phase, summed over all redirects
# TYPE probe_http_duration_seconds gauge
probe_http_duration_seconds{phase="connect"} 0.000878359
probe_http_duration_seconds{phase="processing"} 0.001725035
probe_http_duration_seconds{phase="resolve"} 0.003709816
probe_http_duration_seconds{phase="tls"} 0.003300463
probe_http_duration_seconds{phase="transfer"} 9.0415e-05
...
```

### cloudzero

Cloudzero is a tool to consolidate cost information, enrich with context, and distribute to the organization. One of the many capabilities it has is to allocate a single cost to other non-billed resources. A prime example of this is the EKS compute costs; we have a lot of EC2 instances running for the cluster but only parts of those costs should be allocated to the given workload.

To accomplish this workload allocation we use this [CloudZero k8s integration](https://docs.cloudzero.com/docs/installation-of-cloudzero-integration) here. This will provide the telemetry to CloudZero to split the EC2 costs to the underlying workloads correctly.

### depesz


### external-dns

### flagger-system

### flux-system

[FluxCD](https://fluxcd.io/) is the the CD tool we are using to deploy the state from this repo to the actual k8s cluster. This specific application will generate a flux [Kustomization](https://fluxcd.io/flux/components/kustomize/kustomizations/) for each `Environment`.

Some options are exposed as `labels` on the `Environment`, namely:

| Label Key          | Flux Option                                                                      | Default |
|--------------------|----------------------------------------------------------------------------------|---------|
| fluxcd.io/interval | [interval](https://fluxcd.io/flux/components/kustomize/kustomizations/#interval) | 15m     |
| fluxcd.io/prune    | [prune](https://fluxcd.io/flux/components/kustomize/kustomizations/#prune)       | true    |

#### Access control for Flux Kustomizations

`Role` and `RoleBinding` is automatically generated for `teamsWithKustomizationRights` array in `environments/flux-system/main.jsonnet`, if the team is listed either as `owner_group` or in `edit` list inside `service_catalog.json`.

This allows given team to not only control the resources within their application namespace,
but also edit the kustomization, which mostly just means an ability to **Suspend** and **Resume** kustomization.

### goldilocks

See https://github.com/FairwindsOps/goldilocks/tree/master/hack/manifests


### istio-gateway istio-system istio-waypoint

[istio](https://istio.io/) "extends Kubernetes to establish a programmable, application-aware network."

Install istio [using helm charts](https://istio.io/latest/docs/setup/install/helm/):

Waypoint: [Istio Ambient Waypoint Proxy Made Simple](https://istio.io/latest/blog/2023/waypoint-proxy-made-simple/)


### karpenter

[karpenter is](https://aws.github.io/aws-eks-best-practices/karpenter/)...

> an open-source cluster autoscaler that automatically provisions new nodes in
> response to unschedulable pods.

We use a [(default) provisioner](https://archive.eksworkshop.com/beginner/085_scaling_karpenter/set_up_the_provisioner/).
After upgrade switch to [NodePool](https://karpenter.sh/docs/concepts/nodepools/).

Provisioner support for `startupTaints` [was introduced here](https://github.com/aws/karpenter-provider-aws/pull/1727/files#diff-2c69c72fde894934cc12653ad83dd785de50f123b5e5c8e4ff8d33b1c01af87a).


### keda

[KEDA](https://keda.sh/docs/2.16/scalers/aws-sqs/) is a Kubernetes-based Event Driven Autoscaler. With KEDA, you can drive the scaling of any container in Kubernetes based on the number of events needing to be processed.

Autoscaling by:

* CPU
* SQS: https://keda.sh/docs/2.16/scalers/aws-sqs
* Kafka: https://keda.sh/docs/2.16/scalers/apache-kafka

### langsmith

Followed https://docs.smith.langchain.com/self_hosting

Installed via helm with a chart from:

* https://github.com/langchain-ai/helm/blob/main/README.md
* https://langchain-ai.github.io/helm/charts/langsmith/

### llm-proxy

The llm-proxy service provides a centralized proxy for accessing LLMs through a consistent API interface.

A web interface is available via open-webui deployment that connects to the proxy service.

Endpoints:

- Main API: llm-proxy.[account]
- Web UI: open-webui.[account]

Available Models: Azure
- gpt-o3-mini
- gpt-o1
- gpt-o1-mini
- gpt-4o-mini
- text-embedding-3-small
- text-embedding-3-large

Adding new models: When adding new Azure models please remember about setting `base_model` for accurate cost calculations. Documentation can be found [here](https://docs.litellm.ai/docs/providers/azure#spend-tracking-for-azure-openai-models-proxy).

### k8s metrics server

Installed using [helm chart](https://artifacthub.io/packages/helm/metrics-server/metrics-server)

### milvus


### n8n

https://github.com/8gears/n8n-helm-chart

### nodetaint

Problem this solves: have workload pods started only after system-critical pods,
e.g., CSI secret provider and otel, are already running.

How this works:

* [karpenter `startupTaints`](https://karpenter.sh/docs/concepts/nodepools/)
are [used to have the nodes started](../karpenter/main.jsonnet) with the
taint `nodetaint/notready`.
* infrastructure pods are configured with `nodetaint/notready` tolerations
which allows them to start on the newly started nodes.  Other pods without such
tolerations are NOT scheduled on the new nodes.
* this [nodetaint](https://github.com/wish/nodetaint/) controller removes a
pre-configured taint `nodetaint/notready` from a node after the daemonsets
annotated with `nodetaint/system-critical` are running on the node.  This
ensures that the system critical daemonsets are running on a node before it can
run any other pods.


We mark the following daemonsets as system critical:

* `vault-csi-provider`
* `istio-cni-node`
* `istio-ztunnel`

TODO:

* also mark as system critical `opentelemetry-operator-collector-daemonset`


### platform-insights

### Palantir policy-bot

### secrets-store-csi

This namespace is defined elsewhere.  We only add DatadogMonitor's.

### slack-group-updater

### ssl-exporter

SSL metric exporter, [docs](https://github.com/ribbybibby/ssl_exporter).

### strongdm

### trino-a trino-mcp trino-gateway

We deploy [trino](https://trino.io/docs/current/overview.html) using
[helm chart](https://trino.io/docs/current/installation/kubernetes.html).

Configuration

How to verify new Vault secret injection

Step 1. Add new secrets to the `secretsPerEnv` in the `secrets.jsonnet` file

Step 2. Create `init-dev-config.sh` and extend ConfigMaps in the `secrets.jsonnet` file

```jsonnet
configMaps: [
  configMap.new('trino-init-config-script', if account == 'dev' then {
    'init-dev-config.sh': (importstr 'init-dev-config.sh'),
  } else {
    'init-config.sh': (importstr 'init-config.sh'),
  }),
],
```

### upwind-operator

### vault vault-operator

We deploy [bank-vaults](https://bank-vaults.dev/)
[vault-operator](https://github.com/bank-vaults/vault-operator/pkgs/container/vault-operator),
[docs](https://bank-vaults.dev/docs/operator/), using a helm chart.
vault-operator in turn [deploys](https://bank-vaults.dev/docs/operator/) vault.

[vault environment](../vault/) deploys vault-csi-provider using the official HashiCorp Helm chart for vault.

### velero

Velero offers tools to [back up and restore your Kubernetes cluster resources and persistent volumes](https://velero.io/docs/).
[How Velero Works](https://velero.io/docs/v1.13/how-velero-works/).

Velero is scheduled to perform backup daily, namespaces (specifically `vault`) and resources within
the namespace to backup.

Backup Destination is an s3 bucket `velero-<cluster-name>-<cluster-region>-<cluster-accountId>`


### vertical-pod-autoscaler

### zscaler
