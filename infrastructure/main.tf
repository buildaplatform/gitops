data "cloudflare_accounts" "this" {
  name = var.cloudflare_account_name
}

data "cloudflare_zone" "this" {
  name = var.cloudflare_domain
}

module "tunnel" {
  source = "./tunnel"

  account_name = var.cloudflare_account_name
  account_id   = data.cloudflare_accounts.this.accounts[0].id
  zone_id      = data.cloudflare_zone.this.id

  name           = "k3d-laptop"
  tunnel_secret  = var.tunnel_secret
  allowed_emails = var.allowed_emails
}
