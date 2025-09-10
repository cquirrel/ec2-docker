terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "4.52.1"
    }
  }
}
provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

data "cloudflare_zone" "zone" {
  name = var.cloudflare_domain_name
}

# 1. Create the tunnel
resource "cloudflare_tunnel" "example" {
  account_id = var.cloudflare_account_id
  name       = "ec2-lb-tunnel"
  secret = base64encode(random_password.tunnel_secret.result)
}

# 2. Generate a random tunnel secret
resource "random_password" "tunnel_secret" {
  length  = 32
  special = false
}

# 4. DNS record for the app (CNAME → tunnel)
resource "cloudflare_record" "app" {
  zone_id = data.cloudflare_zone.zone.zone_id
  name    = "web"
  content = "${cloudflare_tunnel.example.id}.cfargotunnel.com"
  type    = "CNAME"
  proxied = true
}
