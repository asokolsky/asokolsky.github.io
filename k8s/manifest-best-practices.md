# Kubernetes Manifest Best Practices

A Kubernetes manifest is a declarative description of the desired state of one
or more API objects. Keep manifests in source control and use `kubectl apply`
instead of a sequence of imperative `kubectl create`, `set`, or `edit` commands.
Repeatedly applying the same manifest converges on the same declared state,
which makes changes reviewable, repeatable, and suitable for automation.

YAML is data that describes the desired result, not an imperative sequence of
instructions to execute.

## Object fields

Kubernetes object manifests use these top-level fields:

- `apiVersion` selects the Kubernetes API group and version, such as `v1` for a
  Service or `apps/v1` for a Deployment. Use a version supported by the target
  cluster and replace deprecated versions before upgrading the cluster.
- `kind` identifies the resource type, such as `Deployment`, `Service`, or
  `ConfigMap`. Capitalization matters.
- `metadata` identifies and describes the object.
  - `name` is the stable object name. For generated objects, use `generateName`
    instead.
  - `namespace` makes the target namespace explicit for namespaced resources.
  - `labels` are short identifying key-value pairs used to group and select
    objects. Prefer the shared `app.kubernetes.io/*` labels for applications,
    and ensure controller selectors match the Pod template labels.
  - `annotations` hold non-identifying metadata for people and tools. Use them
    for information that should not be used in selectors.
- `spec` declares the desired state for most resources. Its fields depend on the
  resource `kind`; some resources, such as ConfigMaps and Secrets, use other
  top-level fields instead. Consult the API reference rather than copying fields
  from another kind or API version.

The API server and controllers populate fields such as `status`, `uid`,
`resourceVersion`, `creationTimestamp`, and `managedFields`. Do not copy these
server-managed fields into source-controlled manifests.

This Deployment shows the common structure:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: web
  namespace: example
  labels:
    app.kubernetes.io/name: web
    app.kubernetes.io/instance: web-production
    app.kubernetes.io/managed-by: kubectl
  annotations:
    example.com/owner: platform-team
spec:
  replicas: 2
  selector:
    matchLabels:
      app.kubernetes.io/instance: web-production
  template:
    metadata:
      labels:
        app.kubernetes.io/name: web
        app.kubernetes.io/instance: web-production
    spec:
      containers:
      - name: web
        image: nginx:1.27.3
        ports:
        - name: http
          containerPort: 80
```

## Multiple objects in one file

YAML supports multiple documents in one stream. Put `---` on its own line
between objects:

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: web-config
data:
  LOG_LEVEL: info
---
apiVersion: v1
kind: Service
metadata:
  name: web
spec:
  selector:
    app.kubernetes.io/instance: web-production
  ports:
  - name: http
    port: 80
    targetPort: http
```

`kubectl apply -f manifests.yaml` processes both documents. Group objects that
share a lifecycle; use separate, clearly named files when objects are deployed
or reviewed independently. Document order is not a dependency mechanism, so do
not rely on it for readiness.

## Verify before applying

Use both generic YAML checks and Kubernetes-aware validation:

1. Format consistently and run a YAML parser or linter. Use spaces, not tabs,
   and quote strings when YAML could interpret them as numbers, booleans, or
   dates.

1. Ask the target API server to parse, default, and strictly validate every
   object without persisting it:

   ```sh
   kubectl apply --dry-run=server --validate=strict -f manifests.yaml
   ```

1. Preview changes against live objects:

   ```sh
   kubectl diff -f manifests.yaml
   ```

Server-side dry runs require cluster access and validate installed custom
resources as well as built-in resources. A client-side dry run is useful when
offline, but it cannot prove compatibility with the target cluster's API
versions, admission policies, or custom resource definitions.

Apply only after reviewing the validation and diff results:

```sh
kubectl apply -f manifests.yaml
```

### How Kubernetes verifies a manifest

Verification is layered; no single check proves everything:

1. A YAML parser checks document structure, indentation, scalar types, and
   multi-document separators. It does not understand Kubernetes fields.
1. With `--validate=strict`, the API server decodes each document according to
   the schema for its `apiVersion` and `kind`. Strict field validation rejects
   duplicate or unknown fields instead of silently dropping them. The API
   server publishes its built-in and custom resource schemas using OpenAPI.
1. `--dry-run=server` sends the normal create or update request through
   defaulting, schema validation, and applicable mutating and validating
   admission controls, but skips persistence. This catches cluster-specific
   policy and custom resource errors that a generic YAML tool cannot see.
1. `kubectl diff` compares the proposed objects with live objects and shows the
   changes that an apply would make. This is a review step, not a substitute for
   validation.

A dry run can succeed while the eventual workload still fails at runtime. Image
availability, permissions used after admission, external dependencies,
scheduling capacity, and application behavior need separate tests or health
checks.

### Reuse the model for domain-specific YAML

The same verification mechanism can be implemented for an application's own
YAML format:

1. Define and version a machine-readable schema, commonly JSON Schema or
   OpenAPI. Require a discriminator such as `apiVersion` plus `kind` when the
   application supports multiple document types or schema versions.
1. Parse YAML with duplicate-key detection enabled. Convert the parsed data to
   the data model expected by the schema validator, then reject unknown fields
   unless forward compatibility deliberately requires them.
1. Add semantic validation for rules a schema cannot express, such as unique
   names, valid cross-references, allowed state transitions, and environment
   policy.
1. Provide a side-effect-free `validate`, `plan`, or `--dry-run` command that
   uses the same loading, defaulting, and validation code as the real apply
   operation. A separate implementation is likely to drift.
1. Show a deterministic diff or plan, and run syntax, schema, semantic, and
   dry-run checks in CI before accepting a configuration change.

Keep schema versions backward-compatible where practical, report errors with
the document and field path, and test invalid examples as well as valid ones.
If applying configuration triggers plugins or external services, define a
dry-run contract that prevents side effects throughout that call chain.

### Reuse the resource envelope

The fields `apiVersion`, `kind`, `metadata`, and `spec` are Kubernetes API
conventions, not reserved YAML keywords. Another application can use the same
envelope for its own domain objects as long as it defines and implements their
semantics. For example:

```yaml
apiVersion: billing.example.com/v1
kind: PricingPolicy
metadata:
  name: standard-rates
  namespace: production
  labels:
    billing.example.com/region: eu
  annotations:
    billing.example.com/owner: finance-platform
spec:
  currency: EUR
  hourlyRate: 2.50
```

A domain application can interpret the fields as follows:

- `apiVersion` selects a schema and conversion rules. A group-qualified value
  such as `billing.example.com/v1` avoids collisions and allows independent API
  families to evolve.
- `kind` selects the object type within that API version. The pair of
  `apiVersion` and `kind` should identify exactly one schema.
- `metadata.name` is the stable identity used for updates and references.
- `metadata.namespace` is optional domain scoping. An application could call it
  `tenant`, `project`, or another domain term instead when Kubernetes-compatible
  tooling is not a goal.
- `metadata.labels` contains short, indexable values used for selection and
  grouping. Define label syntax and selector behavior if the application
  supports them.
- `metadata.annotations` contains non-identifying information for people or
  tools. Unlike labels, annotations should not affect object selection.
- `spec` contains user-owned desired state. The application compares it with
  current state and decides which operations are needed.
- `status`, if exposed, contains application-owned observed state. Keep it out
  of authored configuration unless the application has a specific import or
  restore operation.

These names are useful because they form a familiar and extensible contract,
but copying the names alone provides no behavior. The application must define
identity, defaulting, schema selection, updates, reconciliation, and ownership.
For a small configuration format with only one type, a simpler domain-specific
structure may be clearer than adopting the entire envelope.

### Multiple domain objects in one YAML file

The `---` separator is a YAML feature rather than a Kubernetes feature. An
application can accept a YAML stream and process every document as a separate
domain object:

```yaml
apiVersion: billing.example.com/v1
kind: PricingPolicy
metadata:
  name: standard-rates
spec:
  currency: EUR
  hourlyRate: 2.50
---
apiVersion: billing.example.com/v1
kind: Budget
metadata:
  name: production-limit
spec:
  pricingPolicy: standard-rates
  monthlyLimit: 10000
```

Supporting multiple documents requires more than calling a YAML parser:

- use the parser's stream or `load_all` API instead of its single-document API;
- reject empty documents unless they have an intentional meaning;
- select and validate a schema independently for every document;
- report errors with both the document number and field path;
- define whether identities must be unique within the stream and how
  cross-document references are resolved;
- define whether all documents are validated before any are applied;
- define whether application is atomic, best-effort, or independently
  transactional per document;
- do not treat document order as dependency or execution order unless the file
  format explicitly promises that behavior;
- produce one combined plan that identifies additions, updates, unchanged
  objects, and removals.

Multi-document files work well for objects that share a lifecycle. Separate
files are usually clearer when objects have different owners, permissions,
release schedules, or failure boundaries. Applications must document whether
they accept YAML streams; some YAML libraries and configuration loaders read
only the first document.

## Lessons for applications storing data as YAML

YAML is a serialization format, not an application's data model, schema, or
execution language. Applications that use YAML for CI, deployment, automation,
or domain-specific configuration can adopt these Kubernetes practices:

- Define a versioned schema. Include fields such as `apiVersion` and `kind` so
  the application can select the correct schema and migrate older documents.
- Keep schemas authoritative and discoverable. Store them with the application
  source or publish them through an API instead of making users infer valid
  fields from examples.
- Validate in layers: YAML syntax, duplicate keys and scalar types, JSON Schema
  or OpenAPI structure, domain rules and cross-references, then
  environment-specific policy.
- Reject unknown fields by default. A misspelled field that is silently ignored
  is especially dangerous.
- Describe desired state rather than commands. Prefer `replicas: 3` over a
  sequence such as "create three instances" and let the application reconcile
  current state with the declaration.
- Provide `validate`, `plan`, or `--dry-run` using the same parsing, defaulting,
  migration, and validation code as the real operation while suppressing side
  effects.
- Produce a deterministic diff and make repeated application safe. Applying
  unchanged configuration should not create duplicates or repeatedly trigger
  work.
- Define ownership and concurrency behavior. Detect stale updates rather than
  silently overwriting changes from another writer.
- Evolve schemas explicitly with migrations and deprecation warnings. Do not
  reinterpret an existing field incompatibly under the same version.
- Avoid YAML ambiguity. Enable duplicate-key detection, quote ambiguous
  strings, and document whether `---`-separated documents are supported.
- Separate configuration from runtime state. Generated IDs, timestamps, health,
  and other observed-state fields generally do not belong in source-controlled
  YAML.
- Store references to secrets rather than plaintext secret values in
  source-controlled YAML.
- Report the document number and field path for errors, for example
  `document 2: spec.backends[1].port`.
- Test invalid documents as thoroughly as valid examples.

A strong processing pipeline is:

```text
YAML
  -> strict parser
  -> version selection
  -> schema validation
  -> defaults and migration
  -> semantic and policy validation
  -> plan or diff
  -> atomic reconciliation
```

Generic YAML validity proves only that the syntax can be parsed. Schema-aware
validation detects unknown fields, wrong types, and unsupported values; semantic
and policy validation establishes whether otherwise valid data makes sense for
the application and its environment.

## References

- [Objects in Kubernetes](https://kubernetes.io/docs/concepts/overview/working-with-objects/)
- [Kubernetes configuration good practices](https://kubernetes.io/docs/concepts/configuration/overview/)
- [Recommended labels](https://kubernetes.io/docs/concepts/overview/working-with-objects/common-labels/)
- [Labels and selectors](https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/)
- [Annotations](https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/)
- [Declarative management with configuration files](https://kubernetes.io/docs/tasks/manage-kubernetes-objects/declarative-config/)
- [Kubernetes API concepts: validation and dry-run](https://kubernetes.io/docs/reference/using-api/api-concepts/)
