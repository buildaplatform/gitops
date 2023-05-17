#!/usr/bin/env bash

echo "✓ Ensuring deployment ${1} is ready... 🕵"

while [[ $(kubectl get deploy ${1} --namespace ${2} -ojson | jq '.status.unavailableReplicas') != "null" ]]; do
  sleep 10
done
