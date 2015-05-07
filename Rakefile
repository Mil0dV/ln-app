
require 'rake'
require 'rspec/core/rake_task'
require 'yaml'
require 'ansible_spec'
require 'cucumber/rake/task'
require 'dotenv'
require 'pty'

Dotenv.load File.absolute_path('.env')
Dotenv.load File.absolute_path('.env.private')

properties = AnsibleSpec.get_properties

namespace :serverspec do
  properties.each do |property|
    if property["hosts"] == 'all'
      next
    end

    property["hosts"].each do |host|
      desc "Run serverspec for #{property["name"]}"
      RSpec::Core::RakeTask.new(property["name"].to_sym) do |t|
        puts "Run serverspec for #{property["name"]} to #{host}"
        if host.instance_of?(Hash)
          ENV['TARGET_HOST'] = host["uri"]
          ENV['TARGET_PORT'] = host["port"].to_s
          ENV['TARGET_PRIVATE_KEY'] = host["private_key"]
          unless host["user"].nil?
            ENV['TARGET_USER'] = host["user"]
          else
            ENV['TARGET_USER'] = property["user"]
          end
        else
          ENV['TARGET_HOST'] = host
          ENV['TARGET_PRIVATE_KEY'] = '~/.ssh/id_rsa'
          ENV['TARGET_USER'] = property["user"]
        end
        t.pattern = 'roles/{' + property["roles"].join(',') + '}/spec/*_spec.rb'
      end
    end
  end
end

Cucumber::Rake::Task.new(:features, 'Runs Cucumber feature tests on dev stack, creates this if missing') do |t|
  t.cucumber_opts = "--format pretty" # Any valid command line option can go here.
end

namespace 'ln' do
  desc 'Build new Docker image'
  task :build do
   pseudo_term('ansible-playbook -i hosts/dev build.yml')
  end

  desc 'Deploy new build to dev environment'
  task :deploy_dev do
    pseudo_term('ansible-playbook -i hosts/dev app-playbook.yml')
  end

  desc 'Deploy new build to production environment'
  task :deploy_prod do
    pseudo_term('ansible-playbook -i hosts/vagrant_ansible_inventory app-playbook.yml --extra-vars="prod=true"
')
  end

  desc 'Create and provision dev stack'
  task :create_dev_stack do
   pseudo_term('vagrant up')
   system('for h in `grep ssh hosts/dev | cut -d"=" -f2`; do ssh-keyscan $h >> ~/.ssh/known_hosts; done > /dev/null 2>&1')
   pseudo_term('ansible-playbook -i hosts/dev playbook.yml')
  end

  desc 'Create and provision production stack'
  task :create_prod_stack do
   pseudo_term('VAGRANT_VAGRANTFILE=Vagrantfile.prod vagrant up')
   system('for h in `grep ssh hosts/vagrant_ansible_inventory | cut -d"=" -f2`; do ssh-keyscan $h >> ~/.ssh/known_hosts; done > /dev/null 2>&1')
   pseudo_term('ansible-playbook -i hosts/vagrant_ansible_inventory playbook.yml --extra-vars="prod=true"')
  end

  desc 'Destroy dev stack'
  task :destroy_dev_stack do
   pseudo_term('vagrant destroy -f')
  end

  desc 'Destroy production stack'
  task :destroy_prod_stack do
   pseudo_term('VAGRANT_VAGRANTFILE=Vagrantfile.prod vagrant destroy -f')
  end
end

def pseudo_term(command)
  begin
    PTY.spawn( command ) do |stdout, stdin, pid|
      begin
        stdout.each { |line| print line }
      rescue Errno::EIO
      end
    end
  rescue PTY::ChildExited
    puts "The child process exited!"
  end
end
