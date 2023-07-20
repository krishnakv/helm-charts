# spire

<!-- This README.md is generated. Please edit README.md.gotmpl -->

![Version: 0.10.1](https://img.shields.io/badge/Version-0.10.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.7.0](https://img.shields.io/badge/AppVersion-1.7.0-informational?style=flat-square)
[![Development Phase](https://github.com/spiffe/spiffe/blob/main/.img/maturity/dev.svg)](https://github.com/spiffe/spiffe/blob/main/MATURITY.md#development)

A Helm chart for deploying the complete Spire stack including: spire-server, spire-agent, spiffe-csi-driver, spiffe-oidc-discovery-provider and spire-controller-manager.

**Homepage:** <https://github.com/spiffe/helm-charts/tree/main/charts/spire>

## Version support

> **Note**: This Chart is still in development and still subject to change the API (`values.yaml`).
> Until we reach a `1.0.0` version of the chart we can't guarantee backwards compatibility although
> we do aim for as much stability as possible.

| Dependency | Supported Versions |
|:-----------|:-------------------|
| SPIRE      | `1.5.3+`, `1.6.3+` |
| Helm       | `3.x`              |
| Kubernetes | `1.22+`            |

> **Note**: For Kubernetes, we will officially support the last 3 versions as described in [k8s versioning](https://kubernetes.io/releases/version-skew-policy/#supported-versions). Any version before the last 3 we will try to support as long it doesn't bring security issues or any big maintenance burden.

## Prerequisites

Please note this chart requires `Projected Service Account Tokens` which has to be enabled on your k8s api server.

To enable Projected Service Account Tokens on Docker for Mac/Windows run the following
command to SSH into the Docker Desktop K8s VM.

```bash
docker run -it --privileged --pid=host debian nsenter -t 1 -m -u -n -i sh
```

Then add the following to `/etc/kubernetes/manifests/kube-apiserver.yaml`

```yaml
spec:
  containers:
    - command:
        - kube-apiserver
        - --api-audiences=api,spire-server
        - --service-account-issuer=api,spire-agent
        - --service-account-key-file=/run/config/pki/sa.pub
        - --service-account-signing-key-file=/run/config/pki/sa.key
```

## Usage

To utilize Spire in your own workloads you should add the following to your workload:

```diff
 apiVersion: v1
 kind: Pod
 metadata:
   name: my-app
 spec:
   containers:
     - name: my-app
       image: "my-app:latest"
       imagePullPolicy: Always
+      volumeMounts:
+        - name: spiffe-workload-api
+          mountPath: /spiffe-workload-api
+          readOnly: true
       resources:
         requests:
           cpu: 200m
           memory: 32Mi
         limits:
           cpu: 500m
           memory: 64Mi
+  volumes:
+    - name: spiffe-workload-api
+      csi:
+        driver: "csi.spiffe.io"
+        readOnly: true
```

Now you can interact with the Spire agent socket from your own application. The socket is mounted on `/spiffe-workload-api/spire-agent.sock`.

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| marcofranssen | <marco.franssen@gmail.com> | <https://marcofranssen.nl> |
| kfox1111 | <Kevin.Fox@pnnl.gov> |  |
| faisal-memon | <fymemon@yahoo.com> |  |
| edwbuck | <edwbuck@gmail.com> |  |

## Source Code

* <https://github.com/spiffe/helm-charts/tree/main/charts/spire>

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| file://./charts/spiffe-csi-driver | spiffe-csi-driver | 0.1.0 |
| file://./charts/spiffe-oidc-discovery-provider | spiffe-oidc-discovery-provider | 0.1.0 |
| file://./charts/spire-agent | spire-agent | 0.1.0 |
| file://./charts/spire-server | spire-server | 0.1.0 |
| file://./charts/tornjak-frontend | tornjak-frontend | 0.1.0 |

## Parameters

### Global parameters

| Name                           | Description                                      | Value                        |
| ------------------------------ | ------------------------------------------------ | ---------------------------- |
| `global.k8s.clusterDomain`     | Cluster domain name configured for Spire install | `cluster.local`              |
| `global.spire.bundleConfigMap` | A configmap containing the Spire bundle          | `""`                         |
| `global.spire.clusterName`     | The name of the k8s cluster for Spire install    | `example-cluster`            |
| `global.spire.image.registry`  | Image registry override                          | `""`                         |
| `global.spire.jwtIssuer`       | The issuer for Spire JWT tokens                  | `oidc-discovery.example.org` |
| `global.spire.trustDomain`     | The trust domain for Spire install               | `example.org`                |

### Spire server parameters

| Name                                                                          | Description                                                     | Value                                                                                          |
| ----------------------------------------------------------------------------- | --------------------------------------------------------------- | ---------------------------------------------------------------------------------------------- |
| `spire-server.enabled`                                                        | Flag to enable Spire server                                     | `true`                                                                                         |
| `spire-server.fullnameOverride`                                               | Overrides the full name of Spire server pods                    | `""`                                                                                           |
| `spire-server.nameOverride`                                                   | Overrides the name of Spire server pods                         | `server`                                                                                       |
| `spire-server.namespaceOverride`                                              | Overrides the namespace where Spire server pods are installed   | `""`                                                                                           |
| `spire-server.clusterName`                                                    | Cluster name configured for Spire servers                       | `example-cluster`                                                                              |
| `spire-server.clusterDomain`                                                  | Cluster domain for Spire servers                                | `cluster.local`                                                                                |
| `spire-server.trustDomain`                                                    | Domain name for Spire server trust bundle                       | `example.org`                                                                                  |
| `spire-server.bundleConfigMap`                                                | Config map name for Spire servers trust bundle                  | `spire-bundle`                                                                                 |
| `spire-server.caKeyType`                                                      | Key type for certificate authority                              | `rsa-2048`                                                                                     |
| `spire-server.caTTL`                                                          | TTL for certificate authority                                   | `24h`                                                                                          |
| `spire-server.defaultJwtSvidTTL`                                              | Default TTL for JWT tokens issued by Spire                      | `1h`                                                                                           |
| `spire-server.defaultX509SvidTTL`                                             | Default TTL for X509 tokens issued by Spire                     | `4h`                                                                                           |
| `spire-server.jwtIssuer`                                                      | Issuer for JWT tokens                                           | `oidc-discovery.example.org`                                                                   |
| `spire-server.logLevel`                                                       | Log level for Spire servers                                     | `info`                                                                                         |
| `spire-server.replicaCount`                                                   | Replica count for Spire servers                                 | `1`                                                                                            |
| `spire-server.global.k8s.clusterDomain`                                       | Cluster domain name configured for Spire server                 | `cluster.local`                                                                                |
| `spire-server.global.spire.bundleConfigMap`                                   | Bundle config map for Spire server                              | `""`                                                                                           |
| `spire-server.global.spire.clusterName`                                       | The name of the k8s cluster for Spire server                    | `example-cluster`                                                                              |
| `spire-server.global.spire.image.registry`                                    | Image registry for Spire server                                 | `""`                                                                                           |
| `spire-server.global.spire.jwtIssuer`                                         | JWT Issuer configured for Spire server                          | `oidc-discovery.example.org`                                                                   |
| `spire-server.global.spire.trustDomain`                                       | Trust domain name configured for Spire server                   | `example.org`                                                                                  |
| `spire-server.ca_subject.common_name`                                         | Common name for CA                                              | `example.org`                                                                                  |
| `spire-server.ca_subject.country`                                             | Country for CA                                                  | `NL`                                                                                           |
| `spire-server.ca_subject.organization`                                        | Organization for CA                                             | `Example`                                                                                      |
| `spire-server.configMap.annotations`                                          |                                                                 | `{}`                                                                                           |
| `spire-server.controllerManager.enabled`                                      | Enable controller manager and provision CRD's                   | `true`                                                                                         |
| `spire-server.controllerManager.configMap.annotations`                        |                                                                 | `{}`                                                                                           |
| `spire-server.controllerManager.identities.enabled`                           | Create a Spire server entry                                     | `true`                                                                                         |
| `spire-server.controllerManager.identities.dnsNameTemplates`                  | DNS name teamplates for Spire server entry                      | `[]`                                                                                           |
| `spire-server.controllerManager.identities.federatesWith`                     | List of Spire servers for federation of entries                 | `[]`                                                                                           |
| `spire-server.controllerManager.identities.namespaceSelector`                 | Namespace selector for Spire server entry                       | `{}`                                                                                           |
| `spire-server.controllerManager.identities.podSelector`                       | Pod selector for Spire server setting                           | `{}`                                                                                           |
| `spire-server.controllerManager.identities.spiffeIDTemplate`                  | Template for SPIFFE ID                                          | `spiffe://{{ .TrustDomain }}/ns/{{ .PodMeta.Namespace }}/sa/{{ .PodSpec.ServiceAccountName }}` |
| `spire-server.controllerManager.ignoreNamespaces`                             | Namespaces List of namespaces to ignore for Spire server entry  | `["kube-system","kube-public","local-path-storage"]`                                           |
| `spire-server.controllerManager.image.pullPolicy`                             | Cluster pull policy                                             | `IfNotPresent`                                                                                 |
| `spire-server.controllerManager.image.registry`                               | Registry for Spire controller manager images                    | `ghcr.io`                                                                                      |
| `spire-server.controllerManager.image.repository`                             | Repository for the Spire controller manager image               | `spiffe/spire-controller-manager`                                                              |
| `spire-server.controllerManager.image.tag`                                    | Tag for Spire controller manager image                          | `0.2.3`                                                                                        |
| `spire-server.controllerManager.image.version`                                | App version for Spire controller manager image                  | `""`                                                                                           |
| `spire-server.controllerManager.resources`                                    | Resources request and limits for Spire controller manager       | `{}`                                                                                           |
| `spire-server.controllerManager.securityContext`                              | Security contexts to be set at a pod level                      | `{}`                                                                                           |
| `spire-server.controllerManager.service.annotations`                          | Annotations for service object                                  | `{}`                                                                                           |
| `spire-server.controllerManager.service.port`                                 | Service port                                                    | `443`                                                                                          |
| `spire-server.controllerManager.service.type`                                 | Service type                                                    | `ClusterIP`                                                                                    |
| `spire-server.controllerManager.validatingWebhookConfiguration.failurePolicy` | Failure policy can be "Ignore" or "Fail"                        | `Fail`                                                                                         |
| `spire-server.affinity`                                                       | Node affinity for Spire server pods                             | `{}`                                                                                           |
| `spire-server.autoscaling.enabled`                                            | Enable horizontal pod autoscaling                               | `false`                                                                                        |
| `spire-server.autoscaling.maxReplicas`                                        | Maximum replicas for autoscaling                                | `100`                                                                                          |
| `spire-server.autoscaling.minReplicas`                                        | Minimum replicas for autoscaling                                | `1`                                                                                            |
| `spire-server.autoscaling.targetCPUUtilizationPercentage`                     | Target CPU utilization                                          | `80`                                                                                           |
| `spire-server.dataStore.sql.databaseName`                                     | Database name                                                   | `spire`                                                                                        |
| `spire-server.dataStore.sql.databaseType`                                     | Database type supported values "sqlite3", "mysql" or "postgres" | `sqlite3`                                                                                      |
| `spire-server.dataStore.sql.host`                                             | Hostname for datastore                                          | `""`                                                                                           |
| `spire-server.dataStore.sql.port`                                             | Port for datastore                                              | `0`                                                                                            |
| `spire-server.dataStore.sql.options`                                          | Options specific to datastore                                   | `[]`                                                                                           |
| `spire-server.dataStore.sql.username`                                         | Username for datastore                                          | `spire`                                                                                        |
| `spire-server.dataStore.sql.password`                                         | Password for datastore                                          | `""`                                                                                           |
| `spire-server.dataStore.sql.plugin_data`                                      | Additional configuration for the datastore Spire server plugin  | `{}`                                                                                           |
| `spire-server.initContainers`                                                 | Init container definitions for Spire server pods                | `[]`                                                                                           |
| `spire-server.extraContainers`                                                | Additional container definitions to run alongside Spire server  | `[]`                                                                                           |
| `spire-server.extraVolumes`                                                   | Additional volumes to attach to Spire server pods               | `[]`                                                                                           |
| `spire-server.extraVolumeMounts`                                              | Additional volume mounts for Spire server container             | `[]`                                                                                           |
| `spire-server.federation.enabled`                                             | Enable federation for Spire server                              | `false`                                                                                        |
| `spire-server.federation.bundleEndpoint.address`                              | Address for bundle endpoint for federation                      | `0.0.0.0`                                                                                      |
| `spire-server.federation.bundleEndpoint.port`                                 | Port for bundle endpoint for federation                         | `8443`                                                                                         |
| `spire-server.federation.ingress.enabled`                                     | Enable ingress for Spire server                                 | `false`                                                                                        |
| `spire-server.federation.ingress.className`                                   | Ingress class name                                              | `""`                                                                                           |
| `spire-server.federation.ingress.annotations`                                 | Annotations for ingress object                                  | `{}`                                                                                           |
| `spire-server.federation.ingress.hosts`                                       | List of hosts configured for ingress with path                  | `[]`                                                                                           |
| `spire-server.federation.ingress.tls`                                         | List of tls secrets for ingress                                 | `[]`                                                                                           |
| `spire-server.image.pullPolicy`                                               | Cluster pull policy                                             | `IfNotPresent`                                                                                 |
| `spire-server.image.registry`                                                 | Registry for Spire server images                                | `ghcr.io`                                                                                      |
| `spire-server.image.repository`                                               | Repository for the Spire server image                           | `spiffe/spire-server`                                                                          |
| `spire-server.image.tag`                                                      | Tag for Spire server image                                      | `""`                                                                                           |
| `spire-server.image.version`                                                  | App version for Spire server image                              | `""`                                                                                           |
| `spire-server.imagePullSecrets`                                               | Pull secrets for authenticated registries                       | `[]`                                                                                           |
| `spire-server.ingress.enabled`                                                | Enable ingress for Spire server                                 | `false`                                                                                        |
| `spire-server.ingress.className`                                              | Ingress class name                                              | `""`                                                                                           |
| `spire-server.ingress.annotations`                                            | Annotations for ingress object                                  | `{}`                                                                                           |
| `spire-server.ingress.hosts`                                                  | List of hosts configured for ingress with path                  | `[]`                                                                                           |
| `spire-server.ingress.tls`                                                    | List of tls secrets for ingress                                 | `[]`                                                                                           |
| `spire-server.livenessProbe.failureThreshold`                                 | Failure threshold for pod liveness probe                        | `2`                                                                                            |
| `spire-server.livenessProbe.initialDelaySeconds`                              | Initial delay in seconds for pod liveness probe                 | `15`                                                                                           |
| `spire-server.livenessProbe.periodSeconds`                                    | Period in seconds for pod liveness probe                        | `60`                                                                                           |
| `spire-server.livenessProbe.timeoutSeconds`                                   | Timeout in seconds for pod liveness probe                       | `3`                                                                                            |
| `spire-server.readinessProbe.initialDelaySeconds`                             | Initial delay in seconds for pod readiness probe                | `5`                                                                                            |
| `spire-server.readinessProbe.periodSeconds`                                   | Health check period in seconds for pod readiness probe          | `5`                                                                                            |
| `spire-server.nodeSelector`                                                   | Nodeselector details for Spire server pods                      | `{}`                                                                                           |
| `spire-server.nodeAttestor.k8sPsat.enabled`                                   | Enable Spire server nodeattestor plugin using k8sPsat           | `true`                                                                                         |
| `spire-server.nodeAttestor.k8sPsat.serviceAccountAllowList`                   | List of service accounts allowed for k8sPsat                    | `[]`                                                                                           |
| `spire-server.notifier.k8sbundle.namespace`                                   | Namespace for notifier to push CA bundle                        | `""`                                                                                           |
| `spire-server.persistence.accessMode`                                         | Access mode of underlying PV                                    | `ReadWriteOnce`                                                                                |
| `spire-server.persistence.size`                                               | Size of underlying PVC                                          | `1Gi`                                                                                          |
| `spire-server.podAnnotations`                                                 | Annotations to be added at a pod level                          | `{}`                                                                                           |
| `spire-server.podSecurityContext`                                             | Security contexts to be set at a container level                | `{}`                                                                                           |
| `spire-server.resources`                                                      | Resources request and limits for Spire server                   | `{}`                                                                                           |
| `spire-server.securityContext`                                                | Security contexts to be set at a pod level                      | `{}`                                                                                           |
| `spire-server.service.annotations`                                            | Annotations for service object                                  | `{}`                                                                                           |
| `spire-server.service.port`                                                   | Service port                                                    | `8081`                                                                                         |
| `spire-server.service.type`                                                   | Service type                                                    | `ClusterIP`                                                                                    |
| `spire-server.serviceAccount.create`                                          | Flag for service account creation                               | `true`                                                                                         |
| `spire-server.serviceAccount.name`                                            | Name of service account for Spire server                        | `""`                                                                                           |
| `spire-server.serviceAccount.annotations`                                     | Annotations to be added to service account                      | `{}`                                                                                           |
| `spire-server.telemetry.prometheus.enabled`                                   | Flag to enable prometheus monitoring                            | `false`                                                                                        |
| `spire-server.telemetry.prometheus.podMonitor.enabled`                        | Flag for enabling podMonitor                                    | `false`                                                                                        |
| `spire-server.telemetry.prometheus.podMonitor.namespace`                      | Namespace for podMonitor                                        | `""`                                                                                           |
| `spire-server.telemetry.prometheus.podMonitor.labels`                         | Labels for podMonitor                                           | `{}`                                                                                           |
| `spire-server.tests.bash.image.pullPolicy`                                    | Cluster pull policy                                             | `IfNotPresent`                                                                                 |
| `spire-server.tests.bash.image.registry`                                      | Registry for testing bash image                                 | `cgr.dev`                                                                                      |
| `spire-server.tests.bash.image.repository`                                    | Repository for testing bash image                               | `chainguard/bash`                                                                              |
| `spire-server.tests.bash.image.tag`                                           | Tag for testing bash image                                      | `5.2.15`                                                                                       |
| `spire-server.tests.bash.image.version`                                       | App version for testing bash image                              | `""`                                                                                           |
| `spire-server.tolerations`                                                    | Specifies pod tolerations                                       | `[]`                                                                                           |
| `spire-server.tools.kubectl.image.pullPolicy`                                 | Cluster pull policy                                             | `IfNotPresent`                                                                                 |
| `spire-server.tools.kubectl.image.registry`                                   | Registry for kubectl image                                      | `docker.io`                                                                                    |
| `spire-server.tools.kubectl.image.repository`                                 | Repository for kubectl image                                    | `rancher/kubectl`                                                                              |
| `spire-server.tools.kubectl.image.tag`                                        | Tag for kubectl image                                           | `""`                                                                                           |
| `spire-server.tools.kubectl.image.version`                                    | App version for kubectl image                                   | `""`                                                                                           |
| `spire-server.topologySpreadConstraints`                                      | Specifies topology spread constraints for pod scheduling        | `[]`                                                                                           |
| `spire-server.tornjak.enabled`                                                | Flag to enable tornjak on the server side                       | `false`                                                                                        |
| `spire-server.tornjak.config.dataStore.driver`                                | Tornjak datastore driver                                        | `sqlite3`                                                                                      |
| `spire-server.tornjak.config.dataStore.file`                                  | File path for datastore plugin                                  | `/run/spire/data/tornjak.sqlite3`                                                              |
| `spire-server.tornjak.image.pullPolicy`                                       | Cluster pull policy                                             | `IfNotPresent`                                                                                 |
| `spire-server.tornjak.image.registry`                                         | Registry for Tornjak image                                      | `ghcr.io`                                                                                      |
| `spire-server.tornjak.image.repository`                                       | Repository for Tornjak image                                    | `spiffe/tornjak-backend`                                                                       |
| `spire-server.tornjak.image.tag`                                              | Tag for Tornjak image                                           | `v1.2.2`                                                                                       |
| `spire-server.tornjak.image.version`                                          | App version for Tornjak image                                   | `""`                                                                                           |
| `spire-server.tornjak.resources`                                              | Resources request and limits for Tornjak image                  | `{}`                                                                                           |
| `spire-server.tornjak.service.annotations`                                    | Annotations for service object                                  | `{}`                                                                                           |
| `spire-server.tornjak.service.port`                                           | Service port                                                    | `10000`                                                                                        |
| `spire-server.tornjak.service.type`                                           | Service type                                                    | `ClusterIP`                                                                                    |
| `spire-server.tornjak.startupProbe.initialDelaySeconds`                       | Initial delay in seconds for pod startup probe                  | `5`                                                                                            |
| `spire-server.tornjak.startupProbe.periodSeconds`                             | Period in seconds for pod startup probe                         | `10`                                                                                           |
| `spire-server.tornjak.startupProbe.timeoutSeconds`                            | Timeout in seconds for pod startup probe                        | `5`                                                                                            |
| `spire-server.tornjak.startupProbe.successThreshold`                          | Success threshold for pod startup probe                         | `1`                                                                                            |
| `spire-server.tornjak.startupProbe.failureThreshold`                          | Failure threshold for pod startup probe                         | `3`                                                                                            |
| `spire-server.upstreamAuthority.certManager.enabled`                          | Flag to enable cert manager upstream authority                  | `false`                                                                                        |
| `spire-server.upstreamAuthority.certManager.issuer_group`                     | Issuer group for cert manager                                   | `cert-manager.io`                                                                              |
| `spire-server.upstreamAuthority.certManager.issuer_kind`                      | Issuer kind for cert manager                                    | `Issuer`                                                                                       |
| `spire-server.upstreamAuthority.certManager.issuer_name`                      | Name of cert issuer                                             | `""`                                                                                           |
| `spire-server.upstreamAuthority.certManager.kube_config_file`                 | K8s configuration to connect to API server                      | `""`                                                                                           |
| `spire-server.upstreamAuthority.certManager.namespace`                        | Namespace for cert manager                                      | `""`                                                                                           |
| `spire-server.upstreamAuthority.certManager.ca.create`                        | Flag to enable cert manager upstream CA                         | `false`                                                                                        |
| `spire-server.upstreamAuthority.certManager.ca.duration`                      | Duration                                                        | `87600h`                                                                                       |
| `spire-server.upstreamAuthority.certManager.ca.privateKey.algorithm`          | issuer_kind Issuer kind for cert manager                        | `ECDSA`                                                                                        |
| `spire-server.upstreamAuthority.certManager.ca.privateKey.rotationPolicy`     | Name of cert issuer                                             | `""`                                                                                           |
| `spire-server.upstreamAuthority.certManager.ca.privateKey.size`               | K8s configuration to connect to API server                      | `256`                                                                                          |
| `spire-server.upstreamAuthority.certManager.ca.renewBefore`                   | Namespace for cert manager                                      | `""`                                                                                           |
| `spire-server.upstreamAuthority.certManager.rbac.create`                      | Flag for creation of cert manager RBAC role                     | `true`                                                                                         |
| `spire-server.upstreamAuthority.disk.enabled`                                 | Flag for disk upstream authority plugin                         | `false`                                                                                        |
| `spire-server.upstreamAuthority.disk.secret.create`                           | Create secret to hold CA                                        | `true`                                                                                         |
| `spire-server.upstreamAuthority.disk.secret.name`                             | Name for secret                                                 | `spiffe-upstream-ca`                                                                           |
| `spire-server.upstreamAuthority.disk.secret.data.bundle`                      | Data bundle for disk upstream authority                         | `""`                                                                                           |
| `spire-server.upstreamAuthority.disk.secret.data.certificate`                 | Certificate for disk upstream authority                         | `""`                                                                                           |
| `spire-server.upstreamAuthority.disk.secret.data.key`                         | Key for disk upstream authority                                 | `""`                                                                                           |
| `spire-server.upstreamAuthority.spire.enabled`                                | Flag for Spire upstream authority plugin                        | `false`                                                                                        |
| `spire-server.upstreamAuthority.spire.server.address`                         | Address for Spire server                                        | `""`                                                                                           |
| `spire-server.upstreamAuthority.spire.server.port`                            | Port for Spire server                                           | `8081`                                                                                         |

### Spire agent parameters

| Name                                                        | Description                                                                         | Value                                       |
| ----------------------------------------------------------- | ----------------------------------------------------------------------------------- | ------------------------------------------- |
| `spire-agent.enabled`                                       | Flag to enable Spire agent                                                          | `true`                                      |
| `spire-agent.fullnameOverride`                              | Overrides the full name of Spire agent pods                                         | `""`                                        |
| `spire-agent.nameOverride`                                  | Overrides the name of Spire agent pods                                              | `agent`                                     |
| `spire-agent.namespaceOverride`                             | Overrides the namespace where Spire agent pods are installed                        | `""`                                        |
| `spire-agent.clusterName`                                   | Cluster name configured for Spire agents                                            | `example-cluster`                           |
| `spire-agent.trustBundleFormat`                             | Format for Spire agent trust bundle                                                 | `pem`                                       |
| `spire-agent.trustBundleURL`                                | URL for Spire agent trust bundle for federation                                     | `""`                                        |
| `spire-agent.trustDomain`                                   | Domain name for Spire agent trust bundle                                            | `example.org`                               |
| `spire-agent.bundleConfigMap`                               | Config map name for Spire agent trust bundle                                        | `spire-bundle`                              |
| `spire-agent.socketPath`                                    | Path for Spire agent socket                                                         | `/run/spire/agent-sockets/spire-agent.sock` |
| `spire-agent.logLevel`                                      | Log level set for Spire agents                                                      | `info`                                      |
| `spire-agent.global.k8s.clusterDomain`                      | Cluster domain name configured for Spire agent                                      | `cluster.local`                             |
| `spire-agent.global.spire.bundleConfigMap`                  | Spire bundle config map for Spire agent                                             | `""`                                        |
| `spire-agent.global.spire.clusterName`                      | The name of the k8s cluster for Spire agent                                         | `example-cluster`                           |
| `spire-agent.global.spire.image.registry`                   | Image registry for Spire agent                                                      | `""`                                        |
| `spire-agent.global.spire.jwtIssuer`                        | JWT Issuer configured for Spire agent                                               | `oidc-discovery.example.org`                |
| `spire-agent.global.spire.trustDomain`                      | Trust domain name configured for Spire agent                                        | `example.org`                               |
| `spire-agent.configMap.annotations`                         |                                                                                     | `{}`                                        |
| `spire-agent.initContainers`                                | Init container definitions for Spire agent pods                                     | `[]`                                        |
| `spire-agent.extraContainers`                               | Additional container definitions to run alongside Spire agent                       | `[]`                                        |
| `spire-agent.extraVolumes`                                  | Additional volumes to attach to Spire agent pods                                    | `[]`                                        |
| `spire-agent.extraVolumeMounts`                             | Additional volume mounts for Spire agent container                                  | `[]`                                        |
| `spire-agent.fsGroupFix.image.pullPolicy`                   | Image pull policy                                                                   | `Always`                                    |
| `spire-agent.fsGroupFix.image.registry`                     | Registry for bash images to run fs group command                                    | `cgr.dev`                                   |
| `spire-agent.fsGroupFix.image.repository`                   | Repository for the bash images to run fs group command                              | `chainguard/bash`                           |
| `spire-agent.fsGroupFix.image.tag`                          | Tag for bash images to run fs group command                                         | `5.2.15`                                    |
| `spire-agent.fsGroupFix.image.version`                      | App version for bash images to run fs group command                                 | `""`                                        |
| `spire-agent.fsGroupFix.resources`                          | Resources request and limits for fs group command pod                               | `{}`                                        |
| `spire-agent.healthChecks.port`                             | Port for Spire agent pods health check                                              | `9980`                                      |
| `spire-agent.image.pullPolicy`                              | Image pull policy                                                                   | `IfNotPresent`                              |
| `spire-agent.image.registry`                                | Registry for Spire agents                                                           | `ghcr.io`                                   |
| `spire-agent.image.repository`                              | Repository for Spire agents                                                         | `spiffe/spire-agent`                        |
| `spire-agent.image.tag`                                     | Tag for Spire agent images                                                          | `""`                                        |
| `spire-agent.image.version`                                 | App version for Spire agent images                                                  | `""`                                        |
| `spire-agent.imagePullSecrets`                              | Pull secrets for authenticated registries                                           | `[]`                                        |
| `spire-agent.livenessProbe.initialDelaySeconds`             | Initial delay in seconds for pod liveness probe                                     | `15`                                        |
| `spire-agent.livenessProbe.periodSeconds`                   | Health check period in seconds for pod liveness probe                               | `60`                                        |
| `spire-agent.readinessProbe.initialDelaySeconds`            | Initial delay in seconds for pod readiness probe                                    | `15`                                        |
| `spire-agent.readinessProbe.periodSeconds`                  | Health check period in seconds for pod readiness probe                              | `60`                                        |
| `spire-agent.nodeSelector`                                  | Nodeselector details for Spire agent pods                                           | `{}`                                        |
| `spire-agent.podAnnotations`                                | Annotations to be added at a pod level                                              | `{}`                                        |
| `spire-agent.podSecurityContext`                            | Security contexts to be set at a pod level                                          | `{}`                                        |
| `spire-agent.securityContext`                               | Security contexts to be set at a pod level                                          | `{}`                                        |
| `spire-agent.priorityClassName`                             | Priority class name for pod                                                         | `""`                                        |
| `spire-agent.resources`                                     | Resources request and limits for Spire agent                                        | `{}`                                        |
| `spire-agent.server.address`                                | Address override for spire server                                                   | `""`                                        |
| `spire-agent.server.namespaceOverride`                      | Namespace override for Spire server                                                 | `""`                                        |
| `spire-agent.server.port`                                   | Port for Spire server                                                               | `8081`                                      |
| `spire-agent.serviceAccount.create`                         | Flag for service account creation                                                   | `true`                                      |
| `spire-agent.serviceAccount.name`                           | Name of service account for CSI driver                                              | `""`                                        |
| `spire-agent.serviceAccount.annotations`                    | Annotations to be added to service account                                          | `{}`                                        |
| `spire-agent.telemetry.prometheus.enabled`                  | Flag to enable prometheus monitoring                                                | `false`                                     |
| `spire-agent.telemetry.prometheus.port`                     | Port for metrics endpoints                                                          | `9988`                                      |
| `spire-agent.telemetry.prometheus.podMonitor.enabled`       | Flag for enabling podMonitor                                                        | `false`                                     |
| `spire-agent.telemetry.prometheus.podMonitor.namespace`     | Namespace for podMonitor                                                            | `""`                                        |
| `spire-agent.telemetry.prometheus.podMonitor.labels`        | Labels for podMonitor                                                               | `{}`                                        |
| `spire-agent.tolerations`                                   | Specifies pod tolerations                                                           | `[]`                                        |
| `spire-agent.waitForIt.image.pullPolicy`                    | Cluster pull policy for image used to wait for Spire server to come up              | `IfNotPresent`                              |
| `spire-agent.waitForIt.image.registry`                      | Registry for image used to wait for Spire server to come up                         | `cgr.dev`                                   |
| `spire-agent.waitForIt.image.repository`                    | Repository for image used to wait for Spire server to come up                       | `chainguard/wait-for-it`                    |
| `spire-agent.waitForIt.image.tag`                           | Tag for image used to wait for Spire server to come up                              | `latest-20230517`                           |
| `spire-agent.waitForIt.image.version`                       | App version for image used to wait for Spire server to come up                      | `""`                                        |
| `spire-agent.waitForIt.resources`                           | Resources request and limits for container used to wait for Spire server to come up | `{}`                                        |
| `spire-agent.workloadAttestors.k8s.skipKubeletVerification` | Configure k8s workload attestor to skip kubelet cert verification                   | `true`                                      |
| `spire-agent.workloadAttestors.unix.enabled`                | Flag to enable unix workload attestor                                               | `false`                                     |
