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
