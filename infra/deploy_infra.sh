#!/bin/bash

if [ -z "$PORTAINER_PASS" ] || [ -z "$NGINX_PM_USER" ] || [ -z "$NGINX_PM_PASS" ]; then
  echo "Error: One or more required environment variables are not set: PORTAINER_PASS, NGINX_PM_USER, NGINX_PM_PASS"
  exit 1
fi

# Backend Variables
BACKEND_BUCKET_NAME="cquirrel-ec2-docker-tf-backend"
BACKEND_DYNAMODB_TABLE="terraform-locks"

# Variables
SRC_FILE="cloud-init.yml"
DST_FILE="cloud-init-processed.yml"

# Cloud-init vars
sed -e "s|#PORTAINER_PASS|$PORTAINER_PASS|g" \
    -e "s|#NGINX_PM_USER|$NGINX_PM_USER|g" \
    -e "s|#NGINX_PM_PASS|$NGINX_PM_PASS|g" \
    "$SRC_FILE" > "$DST_FILE"

terraform init \
  -backend-config="bucket=$BACKEND_BUCKET_NAME" \
  -backend-config="dynamodb_table=$BACKEND_DYNAMODB_TABLE" \
  -backend-config="key=terraform.tfstate" \
  -backend-config="encrypt=true"

terraform apply -auto-approve

terraform output instance_public_dns