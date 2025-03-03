# Multi-Container Pod

From https://blog.devops.dev/advanced-kubernetes-pod-concepts-that-you-should-know-as-a-beginner-50c9ca1327fc

## Why Multi-Container Pods?

Benefits: allows for the specific patterns that improve the efficiency, modularity, and functionality of applications.

## Common Multi-Container Pod Patterns

* Sidecar Pattern: used for tasks such as logging, monitoring, or proxying, the sidecar pattern involves an auxiliary container that supports the primary container.
* Adapter Pattern: helps to adapt and transform data between the main container and external systems or storage.
* Ambassador Pattern: used to handle network traffic and act as a proxy for external communications.

## Init Containers

Init Containers are special containers that run before the main application containers in a pod. They help set up required conditions, such as downloading files, initializing databases, or ensuring the environment is ready before the main application starts.

Use Cases of Init Containers:
* Dependency Setup: Pull required images or libraries.
* Configuration Validation: Validate that all configurations are in place.
* Database Initialization: Set up databases or perform migrations before the app starts.

Example configuration with an Init Container that runs a command to ensure that a specific database is ready:
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: init-container-pod
spec:
  initContainers:
  - name: init-db
    image: busybox
    command: ['sh', '-c', 'until nslookup database; do echo waiting for database; sleep 2; done']
  containers:
  - name: main-app
    image: nginx
```
The Init Container (init-db) checks if a service named database is accessible. Only once this check is complete does the main application container (nginx) start.
