variable "instance_swap_size" {
  description = "Server instance swap size in gigabytes"
  type        = number
  default     = 4
}

variable "cf_tunnel_id" {
  description = "Cloudflare Tunnel ID"
  type        = string
}