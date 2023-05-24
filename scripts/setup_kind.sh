#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

if kind export kubeconfig --name "$CLUSTER" ; then
    echo "Using existing kind cluster"
else
    echo "Creating new kind cluster"
    kind create cluster --name "${CLUSTER}" --config "${DIR}"/kind-config.yaml
    kind export kubeconfig --name "$CLUSTER"
fi
