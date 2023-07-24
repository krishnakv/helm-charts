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

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.k8s.clusterDomain | string | `"cluster.local"` | cluster domain name configured for Spire install |
| global.spire.bundleConfigMap | string | `""` | a configmap containing the Spire bundle |
| global.spire.clusterName | string | `"example-cluster"` | the name of the k8s cluster for Spire install |
| global.spire.image | object | `{"registry":""}` | image registry override |
| global.spire.jwtIssuer | string | `"oidc-discovery.example.org"` | the issuer for Spire JWT tokens |
| global.spire.trustDomain | string | `"example.org"` | the trust domain for Spire install |
| spire-server.enabled | bool | `true` | flag to enable Spire server |
| spire-server.fullnameOverride | string | `""` | Overrides the full name of Spire server pods |
| spire-server.nameOverride | string | `"server"` | Overrides the name of Spire server pods |
| spire-server.namespaceOverride | string | `""` | Overrides the namespace where Spire server pods are installed |
| spire-server.clusterName | string | `"example-cluster"` | Cluster name configured for Spire servers |
| spire-server.clusterDomain | string | `"cluster.local"` | Cluster domain for Spire servers |
| spire-server.trustDomain | string | `"example.org"` | Domain name for Spire server trust bundle |
| spire-server.bundleConfigMap | string | `"spire-bundle"` | Config map name for Spire servers trust bundle |
| spire-server.caKeyType | string | `"rsa-2048"` | Key type for certificate authority |
| spire-server.caTTL | string | `"24h"` | CA TTL for certificate authority |
| spire-server.defaultJwtSvidTTL | string | `"1h"` | Default TTL for JWT tokens issued by Spire |
| spire-server.defaultX509SvidTTL | string | `"4h"` | Default TTL for X509 tokens issued by Spire |
| spire-server.jwtIssuer | string | `"oidc-discovery.example.org"` | Issuer for JWT tokens |
| spire-server.logLevel | string | `"info"` | Log level for Spire servers |
| spire-server.replicaCount | int | `1` | Replica count for Spire servers |
| spire-server.global.k8s | object | `{"clusterDomain":"cluster.local"}` | cluster domain name configured for Spire server |
| spire-server.global.spire.bundleConfigMap | string | `""` | bundle config map for Spire server |
| spire-server.global.spire.clusterName | string | `"example-cluster"` | the name of the k8s cluster for Spire server |
| spire-server.global.spire.image.registry | string | `""` | image registry for Spire server |
| spire-server.global.spire.jwtIssuer | string | `"oidc-discovery.example.org"` | JWT Issuer configured for Spire server |
| spire-server.global.spire.trustDomain | string | `"example.org"` | trust domain name configured for Spire server |
| spire-server.global.configMap | object | `{"annotations":{}}` | Configmap annotations |
| spire-server.global.image | object | `{"pullPolicy":"IfNotPresent","registry":"ghcr.io","repository":"spiffe/spire-controller-manager","tag":"0.2.3","version":""}` | Image details for the installation |
| spire-server.global.resources | object | `{}` | Resource limits and quotas for the installation |
| spire-server.global.securityContext | object | `{}` | Security context for the installation |
| spire-server.global.service | object | `{"annotations":{},"port":443,"type":"ClusterIP"}` | Service detials |
| spire-server.extraVolumes | list | `[]` | Additional volumes to be mounted into the container |
| spire-server.livenessProbe | object | `{"failureThreshold":2,"initialDelaySeconds":15,"periodSeconds":60,"timeoutSeconds":3}` | Liveness probe for the installation |
| spire-server.readinessProbe | object | `{"initialDelaySeconds":5,"periodSeconds":5}` | Readiness probe for the installation |
| spire-agent.enabled | bool | `true` | flag to enable Spire server |
| spire-agent.fullnameOverride | string | `""` | overrides the full name of Spire server pods |
| spire-agent.nameOverride | string | `"server"` | overrides the name of Spire server pods |
| spire-agent.namespaceOverride | string | `""` | overrides the namespace where Spire server pods are installed |
| spire-agent.clusterName | string | `"example-cluster"` | cluster name configured for Spire servers |
| spire-agent.trustBundleFormat | string | `"pem"` | format for Spire agent trust bundle |
| spire-agent.trustBundleURL | string | `""` | URL for Spire agent trust bundle for federation |
| spire-agent.trustDomain | string | `"example.org"` | domain name for Spire agent trust bundle |
| spire-agent.bundleConfigMap | string | `"spire-bundle"` | config map name for Spire agent trust bundle |
| spire-agent.socketPath | string | `"/run/spire/agent-sockets/spire-agent.sock"` | path for Spire agent socket |
| spire-agent.logLevel | string | `"info"` | log level set for Spire agents |
| spire-agent.global.k8s.clusterDomain | string | `"cluster.local"` |  |
| spire-agent.global.spire.bundleConfigMap | string | `""` | spire bundle config map for Spire agent |
| spire-agent.global.spire.clusterName | string | `"example-cluster"` | the name of the k8s cluster for Spire agent |
| spire-agent.global.spire.image.registry | string | `""` |  |
| spire-agent.global.spire.jwtIssuer | string | `"oidc-discovery.example.org"` | JWT Issuer configured for Spire agent |
| spire-agent.global.spire.trustDomain | string | `"example.org"` | trust domain name configured for Spire agent |
| spire-agent.configMap | object | `{"annotations":{}}` | Configmap annotations |
| spire-agent.initContainers | list | `[]` | Addiitonal initcontainers to add to the main container |
| spire-agent.extraContainers | list | `[]` | Addiitonal sidecar containers to add to the main container |
| spire-agent.extraVolumes | list | `[]` | Additional volumes to be mounted into the container |
| spire-agent.image | object | `{"pullPolicy":"IfNotPresent","registry":"ghcr.io","repository":"spiffe/spire-agent","tag":"","version":""}` | Image details for the installation |
| spire-agent.imagePullSecrets | list | `[]` | Image pull secrets for pulling from secure registries |
| spire-agent.livenessProbe | object | `{"initialDelaySeconds":15,"periodSeconds":60}` | Liveness probe for the installation |
| spire-agent.readinessProbe | object | `{"initialDelaySeconds":15,"periodSeconds":60}` | Rediness probe for the installation |

----------------------------------------------
