# Click to deploy

## What is included

- [argocd](https://argo-cd.readthedocs.io/en/stable)
- [ingress-nginx](https://kubernetes.github.io/ingress-nginx)
- [cert-manager](https://cert-manager.io)
- [kube-prometheus-stack](https://github.com/prometheus-operator/kube-prometheus)
- [loki](https://grafana.com/oss/loki)
- [tempo](https://grafana.com/oss/tempo)

## Getting Started

### Help

To know what commands you can run use:

```bash
make help
```

### k3d

#### Prerequisites

Download these tools:

- [Docker](https://www.docker.com)
- [Kubectl](https://kubernetes.io/docs/tasks/tools/#kubectl)
- [k3d](https://k3d.io/)
- [Helm](https://helm.sh/docs/intro/install)
- [jq](https://stedolan.github.io/jq/download/)
- [mkcert](https://github.com/FiloSottile/mkcert)

You may need to also download:

- [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

#### Make it run

1. To start the cluster locally use:

    ```bash
    make bootstrap-k3d
    ```

    >A k3d cluster will be created with applications ready and running.

1. Visit the running applications:

    | Application | URL | Notes |
    |---|---|---|
    | ArgoCD | <https://argocd.local.buildaplatform.io> | login information: `make argocd-credentials` |
    | Grafana | <https://grafana.local.buildaplatform.io> | login information: `make grafana-credentials` |
    | Prometheus | <https://prometheus.local.buildaplatform.io> | |
    | Alertmanager | <https://alertmanager.local.buildaplatform.io> | |
    | Postrgres | <https://postgres.local.buildaplatform.io> | |
    | Minio Console | <https://minio-console.local.buildaplatform.io> | login information: `make minio-credentials` |

1. To stop the cluster:

    ```bash
    make stop-k3d
    ```

1. To permanently delete the cluster:

    ```bash
    make destroy-k3d
    ```

#### Make it run with Cloudflare Tunnels

Cloudflare Tunnels can be enabled to allow access to your applications via a domain
name. The `cloudflared`, DNS records, and Tunnels will be created using Terraform.

1. To start the cluster locally with Cloudflare support use:

    ```bash
    CLOUDFLARE=true make bootstrap-k3d
    ```

    >A k3d cluster will be created with applications ready and running.

<!-- TODO: Fix theses to be subdomains with cert-manager and external-dns -->
1. Visit the running applications:

    | Application | URL | Notes |
    |---|---|---|
    | ArgoCD | https://<mydomain.com>/argocd | login information: `make argocd-credentials` |
    | Grafana | https://<mydomain.com>/grafana | login information: `make grafana-credentials` |
    | Prometheus | https://<mydomain.com>/prometheus |
    | Alertmanager | https://<mydomain.com>/alertmanager |

1. To stop the cluster:

    ```bash
    make stop-k3d
    ```

1. To permanently delete the cluster and Cloudflare infrastructure:

    ```bash
    CLOUDFLARE=true make destroy-k3d
    ```
