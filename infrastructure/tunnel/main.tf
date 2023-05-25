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
    "tunnel-config.json" = templatefile("${path.module}/tunnel-config.json", {
      ACCOUNT_NAME  = var.account_name,
      TUNNEL_ID     = cloudflare_record.this.id,
      TUNNEL_NAME   = cloudflare_tunnel.this.name,
      TUNNEL_SECRET = cloudflare_tunnel.this.tunnel_token,
    })
  }
}
