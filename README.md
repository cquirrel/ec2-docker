# EC2 Portainer Nginx (Proxy Manager) [IaC]

This repository lets any GitHub user fork and deploy an AWS EC2 instance with Docker, Portainer, and Nginx—all managed via GitHub Actions.  
**No local setup is required.**  
Just fork, configure your secrets and variables, and use GitHub workflows for easy deployment.  
This is ideal for experimenting or running lightweight projects on AWS Free Tier.

---

## How It Works

- **Fork this repository** to your own GitHub account.
- **Add your AWS credentials and service passwords** as GitHub secrets and variables.
- **Trigger the provided GitHub Actions workflows** to provision and manage your EC2 instance.

Everything is automated by Terraform.

---

## Required GitHub Secrets & Variables

Before running any workflow, set up the following exactly as named below.

| Name                | Type      | Description                                   |
|---------------------|-----------|-----------------------------------------------|
| `AWS_REGION`        | Variable  | The AWS region for resources (e.g., `us-east-1`) |
| `AWS_ACCESS_KEY_ID` | Secret    | Your AWS access key ID                        |
| `AWS_SECRET_ACCESS_KEY` | Secret| Your AWS secret access key                    |
| `BACKEND_BUCKET_NAME` | Secret| Terraform State S3 Bucket (holds state)                   |
| `PORTAINER_PASS`    | Secret    | Initial password for the Portainer admin user |
| `NGINX_PM_USER`     | Secret    | Username for Nginx Proxy Manager              |
| `NGINX_PM_PASS`     | Secret    | Password for Nginx Proxy Manager              |


**How to add:**
1. Go to your forked repository on GitHub.
2. Navigate to **Settings** > **Secrets and variables** > **Actions**.
3. Add the secrets and variables with the exact names above.

**Note:**  
- Names are case-sensitive and must match exactly.

---

## Deployment Steps (follow the order)

1. **Execute the Backend Workflow**

   Terraform needs a remote backend (S3 bucket, DynamoDB) to store its state file.  
   Run the "Backend" workflow to automatically create and configure this in your AWS account.

   > *Why?* Remote state ensures safe, consistent infrastructure management.

2. **Execute the Apply Workflow**

   After the backend is ready, run the "Apply" workflow.  
   This will:
   - Initialize Terraform (using your remote backend)
   - Plan changes
   - Apply the configuration to provision your EC2 instance, Docker, Portainer, and Nginx

   The workflow runs in GitHub Actions and uses your secrets and variables for AWS and service access.  
   Monitor progress in the "Actions" tab.

---

## Accessing Your Services

- **Portainer UI:**  
  Visit `https://<your-ec2-public-ip>:9443`  
  Log in with the username `admin` and the password you set in `PORTAINER_PASS`.

- **Nginx Proxy Manager:**  
  Visit `http://<your-ec2-public-ip>:81`  
  Log in with the username and password you set in `NGINX_PM_USER` and `NGINX_PM_PASS`.

---

## Why Use This Repo?

- **No local tools needed**—everything runs in GitHub Actions
- **Easy to customize**—just fork and edit as you wish
- **Great for AWS Free Tier**—minimal resources provisioned
- **Perfect for demos, learning, or lightweight projects**

---

## Clean Up

To destroy all resources, run the destroy workflow, via GitHub Actions.

---

## License

MIT License. See [LICENSE](LICENSE).
