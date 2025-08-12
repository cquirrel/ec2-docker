#!/bin/bash

# Prompt for input without echoing sensitive values
read -rp "Enter Portainer password: " PORTAINER_PASS
read -rp "Enter Nginx Proxy Manager username: " NGINX_PM_USER
read -rsp "Enter Nginx Proxy Manager password: " NGINX_PM_PASS
echo

# Export them so deploy_infra.sh can use them
export PORTAINER_PASS
export NGINX_PM_USER
export NGINX_PM_PASS

# Call the original script
./deploy_infra.sh