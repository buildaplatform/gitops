resource "cloudflare_tunnel" "this" {
  account_id = var.account_id
  name       = local.full_name
  secret     = var.tunnel_secret
}

resource "cloudflare_record" "this" {
  zone_id = var.zone_id
  name    = local.full_name
  value   = "${cloudflare_tunnel.this.id}.cfargotunnel.com"
  type    = "CNAME"
  proxied = true
}

resource "kubernetes_secret" "this" {
  metadata {
    name      = "tunnel-credentials"
    namespace = "networking"
  }

  data = {
    "tunnel-config.json" = templatefile("${path.module}/tunnel-config.json", {
      ACCOUNT_TAG   = var.account_id,
      TUNNEL_ID     = cloudflare_tunnel.this.id,
      TUNNEL_NAME   = cloudflare_tunnel.this.name,
      TUNNEL_SECRET = var.tunnel_secret,
    })
  }
}
