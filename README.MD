Terraform setup for Lamernews [link]

This project aims to build an infrastructure for lamernews. Here's how:

Install Terraform:
```#{package_manager} install terraform```

If necessary, create a Digital Ocean account. An api token (Personal Access Token) can be generated here:
https://cloud.digitalocean.com/settings/applications

Fill terraform.tfvars.sample with DO api token, Redis PW and management IPs/subnets (CIDR notation) and save as terraform.tfvars

Create SSH key to be used for provisioning:

```ssh-keygen -t rsa -C "deploy-key" -P '' -f deploy-key```

Run 'terraform plan' to inspect what it would do and 'terraform apply'. After this has created the infrastructure you can view the status with 'terraform show'. Connecting to a node can be done with 'ssh -i deploy_key root@#{instance_ip}' 
