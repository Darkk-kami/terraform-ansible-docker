# Infrastructure Automation with Terraform & Ansible

## Project Description
This project uses Terraform to provision cloud infrastructure and Ansible for configuration management. It automates the deployment of a full-stack application and sets up monitoring stacks, focusing on Infrastructure as Code (IaC) and configuration management.

Additionally, it includes automatic DNS management, where the infrastructure provisions an IP address, and the DNS is updated on each deployment to ensure seamless application access.

## Getting Started
The following prequisites must be met
*  AWS CLI with necessary permissions for provisioning resources.

* Terraform for provisioning cloud infrastructure.

* A domain name for setting up application routing and access.

Clone the repository:
```
git clone https://github.com/Darkk-kami/terraform-ansible-docker.git

cd terraform-ansible-docker/dev
```
Configure Terraform
```
terraform init
terraform apply
```

## Further Docmentation

For more advanced setup, troubleshooting, and architecture details, please visit the [wiki](https://github.com/Darkk-kami/terraform-ansible-docker/wiki)
