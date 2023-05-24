#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

if k3d get kubeconfig "$CLUSTER" ; then
    echo "Using existing k3d cluster"
else
    echo "Creating new k3d cluster"
    k3d cluster create --config "${DIR}"/k3d-config.yaml
fi
