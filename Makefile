KIND_CLUSTER ?= ctd
KIND_CONFIG_FILE ?= kind-config.yaml

bootstrap-kind: ## bootstrap an opinionated kind cluster
	@./scripts/bootstrap.sh kind-start

bootstrap-k3d: ## bootstrap an opinionated k3d cluster
	@./scripts/bootstrap.sh k3d-start

.PHONY: argocd
argocd: ## deploy argocd with helm
	@helm upgrade --install argocd argo-cd --repo https://argoproj.github.io/argo-helm --namespace argocd --create-namespace --values ./values/argocd/kind.values.yaml > /dev/null

## --------------------------------------
## kind
## --------------------------------------

kind-start: ## setup kind cluster
	@KIND_CLUSTER="${KIND_CLUSTER}" KIND_CONFIG_FILE=${KIND_CONFIG_FILE} ./scripts/kind_setup.sh

kind-destroy: ## destroy kind cluster
	@kind delete cluster --name "${KIND_CLUSTER}"

## --------------------------------------
## k3d
## --------------------------------------

k3d-start: ## setup k3d cluster
	@k3d cluster create ctd --agents 3 --k3s-arg "--disable=traefik@server:*"

k3d-destroy: ## destroy k3d cluster
	@k3d cluster delete ctd

## --------------------------------------
## tooling
## --------------------------------------

## Self documented: https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
help: ## available make commands
	@grep -E '^[0-9a-zA-Z_-]+:.*?## .*$$' ./Makefile | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
