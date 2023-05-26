#!/usr/bin/env bash

echo "Ensuring namespace ${1} is ready... 🕵"

while [[ $(kubectl get ns ${1} -ojson | jq '.metadata.name') != "${1}" ]]; do
  sleep 10
done
