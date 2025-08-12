BACKEND_BUCKET_NAME="cquirrel-ec2-docker-tf-backend"
BACKEND_DYNAMODB_TABLE="terraform-locks"

DST_FILE="cloud-init-processed.yml"

touch $DST_FILE

terraform init \
  -backend-config="bucket=$BACKEND_BUCKET_NAME" \
  -backend-config="dynamodb_table=$BACKEND_DYNAMODB_TABLE" \
  -backend-config="key=terraform.tfstate" \
  -backend-config="encrypt=true"

terraform apply -auto-approve

rm $DST_FILE