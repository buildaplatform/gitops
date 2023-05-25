resource "cloudflare_tunnel" "this" {
  account_id = var.account_id
  name       = var.name
  secret     = var.tunnel_secret
}

resource "cloudflare_record" "this" {
  zone_id = var.zone_id
  name    = var.name
  value   = "${cloudflare_tunnel.this.id}.cfargotunnel.com"
  type    = "CNAME"
}

resource "kubernetes_secret" "this" {
  metadata {
    name      = "tunnel-credentials"
    namespace = "networking"
  }

  data = {
    AccountTag   = var.account_name
    TunnelID     = cloudflare_record.this.id
    TunnelName   = cloudflare_tunnel.this.name
    TunnelSecret = var.tunnel_secret
  }
}
