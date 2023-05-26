terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "~> 2"
    }
  }
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "k3d-laptop"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}
