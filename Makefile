SHELL := /bin/bash

CLUSTER ?= laptop
CLOUDFLARE ?= false # if true it manages cloudflare resources

.PHONY: argocd
argocd: ## deploy argocd with helm
	@{ \
		helm upgrade --install argocd argo-cd --repo https://argoproj.github.io/argo-helm --namespace argocd --create-namespace --values ./scripts/values.argocd.yaml > /dev/null 2>&1; \
	} || { \
		echo "Failed to deploy ArgoCD" >&2; \
		exit 1; \
	}

argocd-credentials: ## print the argocd admin credentials
	@echo -e "    Username: admin\n    Password: $$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)"

grafana-credentials: ## print the grafana admin credentials
	@echo -e "    Username: admin\n    Password: prom-operator"

## --------------------------------------
## k3d
## --------------------------------------

bootstrap-k3d: ## bootstrap an opinionated k3d cluster
	@./scripts/bootstrap.sh create-k3d

create-k3d: ## create k3d cluster
	@CLUSTER="${CLUSTER}" ./scripts/setup_k3d.sh

start-k3d: ## start an existing k3d cluster
	@k3d cluster start "${CLUSTER}"

stop-k3d: ## stop k3d cluster
	@k3d cluster stop "${CLUSTER}"

destroy-k3d: ## destroy k3d cluster
	@if [[ ${CLOUDFLARE} == "true" ]]; then\
		echo "$$(make --no-print-directory tf-destroy)";\
	fi
	@k3d cluster delete "${CLUSTER}"

## --------------------------------------
## terraform
## --------------------------------------

tf-init: ## init terraform locally
	@terraform -chdir=infrastructure init

tf-plan: tf-init ## plan terraform resources
	@terraform -chdir=infrastructure plan -var-file terraform.tfvars

tf-apply: tf-init ## apply terraform resources
	@terraform -chdir=infrastructure apply -var-file terraform.tfvars -auto-approve

tf-destroy: tf-init ## destroy terraform resources
	@terraform -chdir=infrastructure apply -destroy -var-file terraform.tfvars -auto-approve

## --------------------------------------
## tooling
## --------------------------------------

## Self documented: https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
help: ## available make commands
	@grep -E '^[0-9a-zA-Z_-]+:.*?## .*$$' ./Makefile | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
