#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

make --no-print-directory ${1}
make --no-print-directory argocd
"${DIR}"/wait_for_deployment.sh argocd-server argocd

echo "Bootstraping core Kubernetes applications 🚜"
kubectl apply -f bootstrap.yaml

"${DIR}"/wait_for_deployment.sh ingress-nginx-controller ingress-nginx

"${DIR}"/wait_for_deployment.sh cert-manager cert-manager
"${DIR}"/wait_for_deployment.sh cert-manager-webhook cert-manager
"${DIR}"/wait_for_deployment.sh cert-manager-cainjector cert-manager
"${DIR}"/create_cert.sh

echo ""
echo "Argo CD 🐙"
echo "    Visit https://argocd.local.buildaplatform.io"
make --no-print-directory argocd-credentials
echo ""

echo ""
echo "Grafana 📈"
echo "    Visit https://grafana.local.buildaplatform.io"
make --no-print-directory grafana-credentials
echo ""

if [[ ${CLOUDFLARE} == "true" ]]; then
  make --no-print-directory tf-apply
fi
