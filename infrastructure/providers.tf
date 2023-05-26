terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4"
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

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}
