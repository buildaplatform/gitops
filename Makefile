KIND_CLUSTER ?= ctd
KIND_CONFIG_FILE ?= kind-config.yaml

.PHONY: bootstrap
bootstrap: ## bootstrap an opinionated kind cluster
	@./scripts/bootstrap.sh

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
## tooling
## --------------------------------------

## Self documented: https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
help: ## available make commands
	@grep -E '^[0-9a-zA-Z_-]+:.*?## .*$$' ./Makefile | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
