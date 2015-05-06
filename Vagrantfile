# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

require_relative './vagrant/key_authorization'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  authorize_key_for_root config, '~/.ssh/id_dsa.pub', '~/.ssh/id_rsa.pub'

  config.vm.box = "ubuntu/trusty64"

  {
    'lb1'   => '192.168.33.11',
    'app1'   => '192.168.33.21',
    'app2'   => '192.168.33.22',
    'redis-master' => '192.168.33.14'
  }.each do |short_name, ip|
    config.vm.define short_name do |host|
      host.vm.network 'private_network', ip: ip
      # host.vm.hostname = "#{short_name}.dev"
    end
  end
  #
  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "320"]
  end
end
