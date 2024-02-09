#!/usr/bin/env bash

if [ "$CLUSTER_TYPE" == "k3d" ]; then
    if k3d kubeconfig get "$CLUSTER" >/dev/null 2>&1; then
        echo "Using existing k3d cluster"
    else
        echo "Creating new k3d cluster"
        k3d cluster create "$CLUSTER" --config "./cluster-configs/k3d-config.yaml" >/dev/null 2>&1
    fi
elif [ "$CLUSTER_TYPE" == "kind" ]; then
    if kind export kubeconfig --name "$CLUSTER" >/dev/null 2>&1; then
        echo "Using existing kind cluster"
    else
        echo "Creating new kind cluster"
        kind create cluster --name "${CLUSTER}" --config "./cluster-configs/kind-config.yaml"
        kind export kubeconfig --name "$CLUSTER"
    fi
fi
