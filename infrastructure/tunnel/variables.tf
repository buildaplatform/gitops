variable "account_name" {
  description = "Cloudflare account name"
  type        = string
}

variable "account_id" {
  description = "Cloudflare account id"
  type        = string
}

variable "zone_id" {
  description = "Cloudflare zone id"
  type        = string
}

variable "name" {
  description = "The name of the cluster"
  type        = string
}

variable "tunnel_secret" {
  description = "Cloudflare Tunnel password"
  type        = string
  sensitive   = true
}
