## Infrastructure setup for Lamernews

This project aims to build an infrastructure for [lamernews](https://github.com/antirez/lamernews/). Here's how:


####Setup

Install Ansible via cli
```#{package_manager} install ansible```  

If necessary, create a Digital Ocean account. An api token (Personal Access Token) can be generated here: [https://cloud.digitalocean.com/settings/applications](https://cloud.digitalocean.com/settings/applications)

Fill 'XXXXXXXX.sample' with DO api token and Redis password and save as 'XXXXXXX'

#### Local testing with Vagrant

Install gemset
``bundle install``

Create & start boxes with
``vagrant up``

Run app tests with
``rake serverspec:LN-inf-app``
Redis tests:
``rake serverspec:LN-inf-redis``

Cucumber feature tests:
``rake features``

# todo

Create SSH key to be used for provisioning:

```ssh-keygen -t rsa -C "deploy-key" -P '' -f deploy-key```

####Showtime  
``$ terraform plan```

Check and inspect the output to see what it would do then when you are happy with it run:

```$ terraform apply```

After this has created the infrastructure you can view the status with:

```$ terraform show```

Lamersnews should be up and running on ln-lb's public ip.

Connecting to a node can be done with:

```$ ssh -i deploy_key root@#{instance_ip}```

*NB: this creates 4 droplets on DO, this will cost $0.028/hour. To prevent bankruptcy clean up with 'terraform destroy'*
