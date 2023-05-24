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

- [Docker](https://www.docker.com)
- [Kubectl](https://kubernetes.io/docs/tasks/tools/#kubectl)
- [k3d](https://k3d.io/)
- [Helm](https://helm.sh/docs/intro/install)

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

### kind

#### Prerequisites

- [Docker](https://www.docker.com)
- [Kubectl](https://kubernetes.io/docs/tasks/tools/#kubectl)
- [Kind](https://kind.sigs.k8s.io/docs/user/quick-start/#installing-with-a-package-manager)
- [Helm](https://helm.sh/docs/intro/install)

#### Make it run

1. To start the cluster locally use:

    ```bash
    make bootstrap-kind
    ```

    >A kind cluster will be created with applications ready and running.

1. Visit the running applications:

    | Application | URL | Notes |
    |---|---|---|
    | ArgoCD | <http://localhost/argocd> |
    | Grafana | <http://localhost/grafana> | username:admin, password:prom-opertaor |
    | Prometheus | <http://localhost/prometheus> |
    | Alertmanager | <http://localhost/alertmanager> |

1. To stop the cluster:

    ```bash
    make destroy-kind
    ```
