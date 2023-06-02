#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

if k3d kubeconfig get "$CLUSTER" >/dev/null 2>&1 ; then
    echo "Using existing k3d cluster"
else
    echo "Creating new k3d cluster"
    k3d cluster create --config "${DIR}"/k3d-config.yaml
fi
