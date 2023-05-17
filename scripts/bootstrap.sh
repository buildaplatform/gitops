#!/usr/bin/env bash

set -Eeuxo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

export KIND_CLUSTER="kind"

CLUSTER_NAME=${CLUSTER_NAME:-kind}

echo "Creating Kind cluster"
make kind-start

echo "Installing ArgoCD"
helm upgrade --install argocd argo-cd \
  --repo https://argoproj.github.io/argo-helm \
  --namespace argocd \
  --create-namespace \
  --values "${DIR}"/argocd.values.yaml

echo "Deploying additional Helm Releases"
make deploy
