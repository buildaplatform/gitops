# Click to deploy

## What is included

- [argocd](https://argo-cd.readthedocs.io/en/stable)
- [ingress-nginx](https://kubernetes.github.io/ingress-nginx)
- [kube-prometheus-stack](https://github.com/prometheus-operator/kube-prometheus)
- [loki](https://grafana.com/oss/loki)
- [tempo](https://grafana.com/oss/tempo)
- [opentelemetry](https://opentelemetry.io/)

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

You may need to also install:

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
    | ArgoCD | <http://localhost/argocd> |
    | Grafana | <http://localhost/grafana> | username:admin, password:prom-opertaor |
    | Prometheus | <http://localhost/prometheus> |
    | Alertmanager | <http://localhost/alertmanager> |

1. To stop the cluster:

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

1. Visit the running applications:

    | Application | URL | Notes |
    |---|---|---|
    | ArgoCD | https://<mydomain.com>/argocd | login information: `make argocd-credentials` |
    | Grafana | https://<mydomain.com>/grafana | login information: `make grafana-credentials` |
    | Prometheus | https://<mydomain.com>/prometheus |
    | Alertmanager | https://<mydomain.com>/alertmanager |

1. To stop the cluster:

    ```bash
    CLOUDFLARE=true make destroy-k3d
    ```
