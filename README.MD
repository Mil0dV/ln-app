## Infrastructure setup for Lamernews

This project aims to build an infrastructure for [lamernews](https://github.com/antirez/lamernews/). Here's how:

####Gotta go fast!

*prerequisites*
Install Ansible, Vagrant and Virtualbox via cli

```
#{package_manager} install ansible  
#{package_manager} install vagrant  
#{package_manager} install virtualbox
```
(package names may vary depending on os)
(minimal vagrant version 1.6.3)
---

Install gemset  
```
gem install bundler
bundle install
```
(requires build-essential or equivalent and ruby-dev)

Create dev stack and run Cucumber features against them:  
```
rake ln:create_dev_stack
rake features
```

####What just happened?
If all went well 4 VMs were created, one with redis, 2 with docker + a container running lamernews and a loadbalancer in front of it.

####Additional dev stack features
```
rake ln:create_dev_stack      # Create and provision dev stack
rake ln:deploy_dev            # Deploy new build to dev environment
rake ln:destroy_dev_stack     # Destroy dev stack
```

####Setup for production on DO

To deploy to Digital Ocean the following Vagrant plugins are necessary:
```
vagrant plugin install vagrant-digitalocean
vagrant plugin install vai
```

If necessary, create a Digital Ocean account. An api token (Personal Access Token) can be generated here: [https://cloud.digitalocean.com/settings/applications](https://cloud.digitalocean.com/settings/applications)

Fill '.env.private.sample' with DO api token and save as '.env.private'

You've now unlocked:
```
rake ln:create_prod_stack     # Create and provision production stack
rake ln:deploy_prod           # Deploy new build to production environment
rake ln:destroy_prod_stack    # Destroy production stack
```

Lamersnews should now be up and running on the loadbalancers' public ip's:

``grep lb1p hosts/*``

####Web scale!
Should your site get a bit crowded and traffic-jammy, fear not, help is but a few keystrokes away! In Vagrantfile.prod you can set both the number and the size of the app nodes. Another ``rake ln:create_prod_stack`` and you're good. Redis can be scaled up here as well, for scaling out check the features/redis-ha branch.

####Vagrant

Both environments are also usuable via vagrant, e.g.:
```
vagrant up app1
vagrant ssh app1
VAGRANT_VAGRANTFILE=Vagrantfile.prod vagrant ssh app1p
```

Hostnames are in hosts/dev and the dynamically generated hosts/vagrant_ansible_inventory. Direct root ssh access is also setup for your public key (for this demo usability > security).

####Aditional testing (serverspec)
Besides Cucumber there are also ServerSpecs implemented via ansible_spec. These can be run as follows:

Run app tests with  
``rake serverspec:LN-inf-app``  
Redis tests:  
``rake serverspec:LN-inf-redis``  
Loadbalancer tests:  
``rake serverspec:LN-inf-lb``  

####Updating the app
*prerequisites*
Docker locally or via boot2docker
---

Updates are performed by first building a new docker image, for which you'l need to:  
``docker login``  
(requires dockerhub account)  
And set your username in group_vars/all/dockerhub.

Then you can build with:  
``rake ln:build``  
and finally deploy:  
``rake ln:deploy_dev  
rake ln:deploy_prod``  
