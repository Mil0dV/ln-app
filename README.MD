
Fill terraform.tfvars.sample with AWS keys and management IPs/subnets (CIDR notation) and save as terraform.tfvars

Create SSH key to be used for provisioning:

```ssh-keygen -t rsa -C "deploy-key" -P '' -f deploy-key```
