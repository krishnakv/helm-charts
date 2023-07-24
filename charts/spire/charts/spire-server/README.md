# spire-server

<!-- This README.md is generated. Please edit README.md.gotmpl -->

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.7.0](https://img.shields.io/badge/AppVersion-1.7.0-informational?style=flat-square)

A Helm chart to install the SPIRE server.

**Homepage:** <https://github.com/spiffe/helm-charts/tree/main/charts/spire>

> **Note**: Minimum Spire version is `1.5.3`.
> The recommended version is `1.6.0` to support arm64 nodes. If running with any
> prior version to `1.6.0` you have to use a `nodeSelector` to limit to `kubernetes.io/arch: amd64`.
>
> The recommended spire-controller-manager version is `0.2.2` to support arm64 nodes. If running with any
> prior version to `0.2.2` you have to use a `nodeSelector` to limit to `kubernetes.io/arch: amd64`.

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| marcofranssen | <marco.franssen@gmail.com> | <https://marcofranssen.nl> |
| kfox1111 | <Kevin.Fox@pnnl.gov> |  |
| faisal-memon | <fymemon@yahoo.com> |  |
| edwbuck | <edwbuck@gmail.com> |  |

## Source Code

* <https://github.com/spiffe/helm-charts/tree/main/charts/spire>

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| replicaCount | int | `1` | SPIRE server currently runs with a sqlite database. Scaling to multiple instances will not work until we use an external database. |
| image.registry | string | `"ghcr.io"` | The OCI registry to pull the image from |
| image.repository | string | `"spiffe/spire-server"` | The repository within the registry |
| image.pullPolicy | string | `"IfNotPresent"` | The image pull policy |
| image.version | string | `""` | This value is deprecated in favor of tag. (Will be removed in a future release) |
| image.tag | string | `""` | Overrides the image tag whose default is the chart appVersion. |
| imagePullSecrets | list | `[]` |  |
| nameOverride | string | `""` |  |
| namespaceOverride | string | `""` |  |
| fullnameOverride | string | `""` |  |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| podAnnotations | object | `{}` |  |
| podSecurityContext | object | `{}` |  |
| securityContext | object | `{}` |  |
| service.type | string | `"ClusterIP"` |  |
| service.port | int | `8081` |  |
| service.annotations | object | `{}` |  |
| configMap.annotations | object | `{}` | Annotations to add to the SPIRE Server ConfigMap |
| resources | object | `{}` |  |
| autoscaling.enabled | bool | `false` |  |
| autoscaling.minReplicas | int | `1` |  |
| autoscaling.maxReplicas | int | `100` |  |
| autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| nodeSelector | object | `{}` | Select specific nodes to run on (currently only amd64 is supported by Tornjak) |
| tolerations | list | `[]` |  |
| affinity | object | `{}` |  |
| topologySpreadConstraints | list | `[]` |  |
| livenessProbe.failureThreshold | int | `2` | Failure threshold count for livenessProbe |
| livenessProbe.initialDelaySeconds | int | `15` | Initial delay seconds for livenessProbe |
| livenessProbe.periodSeconds | int | `60` | Period seconds for livenessProbe |
| livenessProbe.timeoutSeconds | int | `3` | Timeout in seconds for livenessProbe |
| readinessProbe.initialDelaySeconds | int | `5` | Initial delay seconds for readinessProbe |
| readinessProbe.periodSeconds | int | `5` | Period seconds for readinessProbe |
| persistence.size | string | `"1Gi"` |  |
| persistence.accessMode | string | `"ReadWriteOnce"` |  |
| persistence.storageClass | string | `nil` |  |
| dataStore.sql.databaseType | string | `"sqlite3"` | Other supported databases are "postgres" and "mysql" |
| dataStore.sql.databaseName | string | `"spire"` | Only used by "postgres" or "mysql" |
| dataStore.sql.host | string | `""` | Only used by "postgres" or "mysql" |
| dataStore.sql.port | int | `0` | If 0 (default), it will auto set to 5432 for postgres and 3306 for mysql. Only used by those databases. |
| dataStore.sql.username | string | `"spire"` | Only used by "postgres" or "mysql" |
| dataStore.sql.password | string | `""` | Only used by "postgres" or "mysql" |
| dataStore.sql.options | list | `[]` | Only used by "postgres" or "mysql" |
| dataStore.sql.plugin_data | object | `{}` | Settings from https://github.com/spiffe/spire/blob/main/doc/plugin_server_datastore_sql.md go in this section |
| logLevel | string | `"info"` | The log level, valid values are "debug", "info", "warn", and "error" |
| jwtIssuer | string | `"oidc-discovery.example.org"` | The JWT issuer domain |
| clusterName | string | `"example-cluster"` |  |
| trustDomain | string | `"example.org"` | Set the trust domain to be used for the SPIFFE identifiers |
| bundleConfigMap | string | `"spire-bundle"` |  |
| clusterDomain | string | `"cluster.local"` |  |
| federation.enabled | bool | `false` |  |
| federation.bundleEndpoint.port | int | `8443` |  |
| federation.bundleEndpoint.address | string | `"0.0.0.0"` |  |
| federation.ingress.enabled | bool | `false` |  |
| federation.ingress.className | string | `""` |  |
| federation.ingress.annotations | object | `{}` |  |
| federation.ingress.hosts[0].host | string | `"spire-server-federation.example.org"` |  |
| federation.ingress.hosts[0].paths[0].path | string | `"/"` |  |
| federation.ingress.hosts[0].paths[0].pathType | string | `"Prefix"` |  |
| federation.ingress.tls | list | `[]` |  |
| ca_subject.country | string | `"NL"` |  |
| ca_subject.organization | string | `"Example"` |  |
| ca_subject.common_name | string | `"example.org"` |  |
| upstreamAuthority.disk.enabled | bool | `false` |  |
| upstreamAuthority.disk.secret.create | bool | `true` | If disabled requires you to create a secret with the given keys (certificate, key and optional bundle) yourself. |
| upstreamAuthority.disk.secret.name | string | `"spiffe-upstream-ca"` | If secret creation is disabled, the secret with this name will be used. |
| upstreamAuthority.disk.secret.data | object | `{"bundle":"","certificate":"","key":""}` | If secret creation is enabled, will create a secret with following certificate info |
| upstreamAuthority.certManager.enabled | bool | `false` |  |
| upstreamAuthority.certManager.rbac.create | bool | `true` |  |
| upstreamAuthority.certManager.issuer_name | string | `""` | Defaults to the release name, override if CA is provided outside of the chart |
| upstreamAuthority.certManager.issuer_kind | string | `"Issuer"` |  |
| upstreamAuthority.certManager.issuer_group | string | `"cert-manager.io"` |  |
| upstreamAuthority.certManager.namespace | string | `""` | Specify to use a namespace other then the one the chart is installed into |
| upstreamAuthority.certManager.kube_config_file | string | `""` |  |
| upstreamAuthority.certManager.ca.create | bool | `false` | Creates a Cert-Manager CA |
| upstreamAuthority.certManager.ca.duration | string | `"87600h"` | Duration of the CA. Defaults to 10 years. |
| upstreamAuthority.certManager.ca.privateKey.algorithm | string | `"ECDSA"` |  |
| upstreamAuthority.certManager.ca.privateKey.size | int | `256` |  |
| upstreamAuthority.certManager.ca.privateKey.rotationPolicy | string | `""` |  |
| upstreamAuthority.certManager.ca.renewBefore | string | `""` | How long to wait before renewing the CA |
| upstreamAuthority.spire.enabled | bool | `false` |  |
| upstreamAuthority.spire.server.address | string | `""` |  |
| upstreamAuthority.spire.server.port | int | `8081` |  |
| notifier.k8sbundle.namespace | string | `""` | Namespace to push the bundle into, if blank will default to SPIRE Server namespace |
| controllerManager.enabled | bool | `false` |  |
| controllerManager.image.registry | string | `"ghcr.io"` | The OCI registry to pull the image from |
| controllerManager.image.repository | string | `"spiffe/spire-controller-manager"` | The repository within the registry |
| controllerManager.image.pullPolicy | string | `"IfNotPresent"` | The image pull policy |
| controllerManager.image.version | string | `""` | This value is deprecated in favor of tag. (Will be removed in a future release) |
| controllerManager.image.tag | string | `"0.2.3"` | Overrides the image tag |
| controllerManager.resources | object | `{}` |  |
| controllerManager.securityContext | object | `{}` |  |
| controllerManager.service.type | string | `"ClusterIP"` |  |
| controllerManager.service.port | int | `443` |  |
| controllerManager.service.annotations | object | `{}` |  |
| controllerManager.configMap.annotations | object | `{}` | Annotations to add to the Controller Manager ConfigMap |
| controllerManager.ignoreNamespaces[0] | string | `"kube-system"` |  |
| controllerManager.ignoreNamespaces[1] | string | `"kube-public"` |  |
| controllerManager.ignoreNamespaces[2] | string | `"local-path-storage"` |  |
| controllerManager.identities.enabled | bool | `true` |  |
| controllerManager.identities.spiffeIDTemplate | string | `"spiffe://{{ .TrustDomain }}/ns/{{ .PodMeta.Namespace }}/sa/{{ .PodSpec.ServiceAccountName }}"` |  |
| controllerManager.identities.podSelector | object | `{}` |  |
| controllerManager.identities.namespaceSelector | object | `{}` |  |
| controllerManager.identities.dnsNameTemplates | list | `[]` |  |
| controllerManager.identities.federatesWith | list | `[]` |  |
| controllerManager.validatingWebhookConfiguration.failurePolicy | string | `"Fail"` |  |
| tools.kubectl.image.registry | string | `"docker.io"` | The OCI registry to pull the image from |
| tools.kubectl.image.repository | string | `"rancher/kubectl"` | The repository within the registry |
| tools.kubectl.image.pullPolicy | string | `"IfNotPresent"` | The image pull policy |
| tools.kubectl.image.version | string | `""` | This value is deprecated in favor of tag. (Will be removed in a future release) |
| tools.kubectl.image.tag | string | `""` | Overrides the image tag |
| telemetry.prometheus.enabled | bool | `false` |  |
| telemetry.prometheus.podMonitor.enabled | bool | `false` |  |
| telemetry.prometheus.podMonitor.namespace | string | `""` | Override where to install the podMonitor, if not set will use the same namespace as the spire-server |
| telemetry.prometheus.podMonitor.labels | object | `{}` |  |
| ingress.enabled | bool | `false` |  |
| ingress.className | string | `""` |  |
| ingress.annotations | object | `{}` |  |
| ingress.hosts[0].host | string | `"spire-server.example.org"` |  |
| ingress.hosts[0].paths[0].path | string | `"/"` |  |
| ingress.hosts[0].paths[0].pathType | string | `"Prefix"` |  |
| ingress.tls | list | `[]` |  |
| extraVolumes | list | `[]` |  |
| extraVolumeMounts | list | `[]` |  |
| extraContainers | list | `[]` |  |
| initContainers | list | `[]` |  |
| caKeyType | string | `"rsa-2048"` | The CA key type to use, possible values are rsa-2048, rsa-4096, ec-p256, ec-p384 (AWS requires the use of RSA.  EC cryptography is not supported) |
| caTTL | string | `"24h"` |  |
| defaultX509SvidTTL | string | `"4h"` |  |
| defaultJwtSvidTTL | string | `"1h"` |  |
| nodeAttestor.k8sPsat.enabled | bool | `true` |  |
| nodeAttestor.k8sPsat.serviceAccountAllowList | list | `[]` |  |
| tornjak.enabled | bool | `false` | Deploys Tornjak API (backend) (Not for production) |
| tornjak.image.registry | string | `"ghcr.io"` | The OCI registry to pull the Tornjak image from |
| tornjak.image.repository | string | `"spiffe/tornjak-backend"` | The repository within the registry |
| tornjak.image.pullPolicy | string | `"IfNotPresent"` | The Tornjak image pull policy |
| tornjak.image.version | string | `""` | This value is deprecated in favor of tag. (Will be removed in a future release) |
| tornjak.image.tag | string | `"v1.2.2"` | Overrides the image tag |
| tornjak.service.type | string | `"ClusterIP"` |  |
| tornjak.service.port | int | `10000` |  |
| tornjak.service.annotations | object | `{}` |  |
| tornjak.startupProbe.failureThreshold | int | `3` |  |
| tornjak.startupProbe.initialDelaySeconds | int | `5` | Initial delay seconds for |
| tornjak.startupProbe.periodSeconds | int | `10` |  |
| tornjak.startupProbe.successThreshold | int | `1` |  |
| tornjak.startupProbe.timeoutSeconds | int | `5` |  |
| tornjak.config.dataStore | object | `{"driver":"sqlite3","file":"/run/spire/data/tornjak.sqlite3"}` | persistent DB for storing Tornjak specific information |
| tornjak.resources | object | `{}` |  |

----------------------------------------------
