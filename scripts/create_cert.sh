#!/usr/bin/env bash
# https://skarlso.github.io/2023/10/25/self-signed-locally-trusted-certificates-with-cert-manager/

echo "Setup SSL Certificates... 🔒"

# Remove existing root CA certificate if it exists
rm -f ~/.buildaplatform/ssl/rootCA.pem

# Create directory if it doesn't exist
mkdir -p $HOME/.buildaplatform/ssl

kubectl apply -f ./scripts/cluster-issuer.local.yaml

echo "Ensuring certificate buildaplatform-certificate is ready... 🕵"
kubectl wait --for=condition=Ready=true Certificate/buildaplatform-certificate --namespace cert-manager --timeout=5m

# Fetch the root CA certificate from Kubernetes secret and decode it
kubectl_cert=$(kubectl get secrets buildaplatform-tls-certs -n cert-manager -o jsonpath="{.data['tls\.crt']}")
if [ -z "$kubectl_cert" ]; then
    echo "Error: Unable to fetch Kubernetes secret."
    exit 1
fi

echo "$kubectl_cert" | base64 -d > $HOME/.buildaplatform/ssl/rootCA.pem

echo "Require sudo to setup mkcert... 🔑"
# Install the root CA certificate using mkcert
if ! CAROOT=~/.buildaplatform/ssl mkcert -install; then
    echo "Error: Unable to install root CA certificate using mkcert."
    exit 1
fi
