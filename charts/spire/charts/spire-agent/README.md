# spire-agent

<!-- This README.md is generated. Please edit README.md.gotmpl -->

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.7.0](https://img.shields.io/badge/AppVersion-1.7.0-informational?style=flat-square)

A Helm chart to install the SPIRE agent.

**Homepage:** <https://github.com/spiffe/helm-charts/tree/main/charts/spire>

> **Note**: Minimum Spire version is `1.5.3`.
> The recommended version is `1.6.0` to support arm64 nodes. If running with any
> prior version to `1.6.0` you have to use a `nodeSelector` to limit to `kubernetes.io/arch: amd64`.

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
| image.registry | string | `"ghcr.io"` | The OCI registry to pull the image from |
| image.repository | string | `"spiffe/spire-agent"` | The repository within the registry |
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
| configMap.annotations | object | `{}` | Annotations to add to the SPIRE Agent ConfigMap |
| podAnnotations | object | `{}` |  |
| podSecurityContext | object | `{}` |  |
| securityContext | object | `{}` |  |
| resources | object | `{}` |  |
| nodeSelector | object | `{}` |  |
| tolerations | list | `[]` |  |
| logLevel | string | `"info"` | The log level, valid values are "debug", "info", "warn", and "error" |
| clusterName | string | `"example-cluster"` |  |
| trustDomain | string | `"example.org"` | The trust domain to be used for the SPIFFE identifiers |
| trustBundleURL | string | `""` | If set, obtain trust bundle from url instead of Kubernetes ConfigMap |
| trustBundleFormat | string | `"pem"` | If using trustBundleURL, what format is the url. Choices are "pem" and "spiffe" |
| bundleConfigMap | string | `"spire-bundle"` |  |
| server.address | string | `""` |  |
| server.port | int | `8081` |  |
| server.namespaceOverride | string | `""` |  |
| healthChecks.port | int | `9980` | override the host port used for health checking |
| livenessProbe.initialDelaySeconds | int | `15` | Initial delay seconds for livenessProbe |
| livenessProbe.periodSeconds | int | `60` | Period seconds for livenessProbe |
| readinessProbe.initialDelaySeconds | int | `15` | Initial delay seconds for readinessProbe |
| readinessProbe.periodSeconds | int | `60` | Period seconds for readinessProbe |
| waitForIt.image.registry | string | `"cgr.dev"` | The OCI registry to pull the image from |
| waitForIt.image.repository | string | `"chainguard/wait-for-it"` | The repository within the registry |
| waitForIt.image.pullPolicy | string | `"IfNotPresent"` | The image pull policy |
| waitForIt.image.version | string | `""` | This value is deprecated in favor of tag. (Will be removed in a future release) |
| waitForIt.image.tag | string | `"latest-20230517"` | Overrides the image tag |
| waitForIt.resources | object | `{}` |  |
| fsGroupFix.image.registry | string | `"cgr.dev"` | The OCI registry to pull the image from |
| fsGroupFix.image.repository | string | `"chainguard/bash"` | The repository within the registry |
| fsGroupFix.image.pullPolicy | string | `"Always"` | The image pull policy |
| fsGroupFix.image.version | string | `""` | This value is deprecated in favor of tag. (Will be removed in a future release) |
| fsGroupFix.image.tag | string | `"5.2.15"` | Overrides the image tag |
| fsGroupFix.resources | object | `{}` | Specify resource needs as per https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/ |
| workloadAttestors.unix.enabled | bool | `false` | enables the Unix workload attestor |
| workloadAttestors.k8s.skipKubeletVerification | bool | `true` | If true, kubelet certificate verification is skipped |
| telemetry.prometheus.enabled | bool | `false` |  |
| telemetry.prometheus.port | int | `9988` |  |
| telemetry.prometheus.podMonitor.enabled | bool | `false` |  |
| telemetry.prometheus.podMonitor.namespace | string | `""` | Override where to install the podMonitor, if not set will use the same namespace as the spire-agent |
| telemetry.prometheus.podMonitor.labels | object | `{}` |  |
| socketPath | string | `"/run/spire/agent-sockets/spire-agent.sock"` | The unix socket path to the spire-agent |
| priorityClassName | string | `""` | Priority class assigned to daemonset pods |
| extraVolumes | list | `[]` |  |
| extraVolumeMounts | list | `[]` |  |
| extraContainers | list | `[]` |  |
| initContainers | list | `[]` |  |

----------------------------------------------
