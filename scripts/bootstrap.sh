#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

make ${1}
make argocd
"${DIR}"/wait_for_deployment.sh argocd-server argocd
kubectl apply -f bootstrap.yaml
"${DIR}"/wait_for_deployment.sh ingress-nginx-controller ingress-nginx

echo ""
echo "Argo CD"
echo "    Visit http://localhost/argocd 🐙"
make argocd-credentials
echo ""

echo ""
echo "Grafana"
echo "    Visit http://localhost/grafana 📈"
make grafana-credentials
echo ""

if [[ ${CLOUDFLARE} == "true" ]]; then
  make tf-apply
fi
