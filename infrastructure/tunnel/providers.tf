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
