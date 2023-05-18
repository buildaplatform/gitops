# Click to deploy

Open source Heroku

## Installation

### kind

#### Required

- [Docker](https://www.docker.com)
- [Kubectl](https://kubernetes.io/docs/tasks/tools/#kubectl)
- [Kind](https://kind.sigs.k8s.io/docs/user/quick-start/#installing-with-a-package-manager)
- [Helm](https://helm.sh/docs/intro/install)

#### Make it run

1. To start the cluster locally use:

    ```bash
    make bootstrap-kind
    ```

    >A kind cluster will be created with argocd and ingress-nginx installed.

1. Visit the running applications:

    | Application | URL | Notes |
    |---|---|---|
    | ArgoCD | <http://localhost/argocd> |
    | Grafana | <http://localhost/grafana> | username:admin, password:prom-opertaor |
    | Prometheus | <http://localhost/prometheus> |
    | Alertmanager | <http://localhost/alertmanager> |
