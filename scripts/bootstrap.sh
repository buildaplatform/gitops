#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

make kind-start
make argocd
"${DIR}"/wait_for_deployment.sh argocd-server argocd
kubectl apply -f bootstrap.yaml
"${DIR}"/wait_for_deployment.sh ingress-nginx-controller ingress-nginx

echo ""
echo "Visit http://localhost/argocd 🤟"
echo ""
