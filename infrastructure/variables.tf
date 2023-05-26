variable "cloudflare_api_token" {
  description = "Cloudflare api token"
  type        = string
}

variable "cloudflare_account_name" {
  description = "Cloudflare account"
  type        = string
}

variable "cloudflare_domain" {
  description = "Cloudflare domain"
  type        = string
}

variable "tunnel_secret" {
  description = "Cloudflare Tunnel password"
  type        = string
  sensitive   = true
}

variable "allowed_emails" {
  description = "Allowed emails to access application"
  type        = list(string)
  default     = []
}
