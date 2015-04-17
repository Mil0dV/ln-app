## Terraform setup for Lamernews

This project aims to build an infrastructure for [lamernews](https://github.com/antirez/lamernews/). Here's how:


####Setup
Install Terraform:  

```#{package_manager} install terraform```  
Or via https://terraform.io/downloads.html

If necessary, create a Digital Ocean account. An api token (Personal Access Token) can be generated here: [https://cloud.digitalocean.com/settings/applications](https://cloud.digitalocean.com/settings/applications)

Fill terraform.tfvars.sample with DO api token and Redis password and save as terraform.tfvars

Create SSH key to be used for provisioning:

```ssh-keygen -t rsa -C "deploy-key" -P '' -f deploy-key```

####Showtime  
Run 'terraform plan' to inspect what it would do and 'terraform apply'. After this has created the infrastructure you can view the status with 'terraform show'. Connecting to a node can be done with 'ssh -i deploy_key root@#{instance_ip}' Lamernews should be up&running on ln-lb's IP.

NB: this creates 4 droplets on DO, this will cost $0.028/hour. To prevent bankruptcy clean up with 'terraform destroy'
