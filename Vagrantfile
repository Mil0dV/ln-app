# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

require_relative './vagrant/key_authorization'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  authorize_key_for_root config, '~/.ssh/id_dsa.pub', '~/.ssh/id_rsa.pub'

  config.vm.box = "ubuntu/trusty64"

  config.vm.define "redis1"
  config.vm.network :private_network, ip: "192.168.33.15"

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--name", "MyCoolApp", "--memory", "512"]
  end

  # Shared folder from the host machine to the guest machine. Uncomment the line
  # below to enable it.
  #config.vm.synced_folder "../../../my-cool-app", "/webapps/mycoolapp/my-cool-app"

  # Ansible provisioner.
  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "vagrant.yml"
    ansible.host_key_checking = false
    ansible.verbose = "v"
  end
end


# {
#   'db1'    => '192.168.33.10',
#   # 'app1'   => '192.168.33.11',
#   'redis1' => '192.168.33.12',
# }.each do |short_name, ip|
#   config.vm.define short_name do |host|
#     host.vm.network 'private_network', ip: ip
#     host.vm.hostname = "#{short_name}.myapp.dev"
#   end
# end
