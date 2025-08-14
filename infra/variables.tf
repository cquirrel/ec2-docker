variable "portainer_password" {
  description = "Portainer UI Admin Password"
  type        = string
}

variable "nginx_proxy_manager_email" {
  description = "Nginx Proxy Manager UI E-mail Address"
  type        = string
}

variable "nginx_proxy_manager_password" {
  description = "Nginx Proxy Manager UI Password"
  type        = string
}

variable "instance_swap_size" {
  description = "Server instance swap size in gigabytes"
  type = number
  default = 4
}