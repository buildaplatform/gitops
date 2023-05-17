KIND_CLUSTER ?= kind
KIND_CONFIG_FILE ?= kind-config.yaml

.PHONY: bootstrap
bootstrap: ## bootstrap a cluster with ArgoCD installed
	./scripts/bootstrap.sh

.PHONY: deploy
deploy:
	helm upgrade --install ingress-nginx ingress-nginx --repo https://kubernetes.github.io/ingress-nginx --values values/ingress-nginx/kind.values.yaml --namespace ingress-nginx --create-namespace

## --------------------------------------
## KinD
## --------------------------------------

kind-start: ## Setup Kind cluster
	KIND_CLUSTER="${KIND_CLUSTER}" KIND_CONFIG_FILE=${KIND_CONFIG_FILE} ./scripts/kind_setup.sh

kind-destroy: ## Destroy Kind cluster
	kind delete cluster --name "${KIND_CLUSTER}"

## --------------------------------------
## Tooling
## --------------------------------------

## Self documented: https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
help: ## Available make commands
	@grep -E '^[0-9a-zA-Z_-]+:.*?## .*$$' ./Makefile | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
