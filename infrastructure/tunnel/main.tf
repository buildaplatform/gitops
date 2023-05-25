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
    AccountTag   = base64encode(var.account_name)
    TunnelID     = base64encode(cloudflare_record.this.id)
    TunnelName   = base64encode(cloudflare_tunnel.this.name)
    TunnelSecret = base64encode(var.tunnel_secret)
  }
}
