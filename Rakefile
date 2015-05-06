
require 'rake'
require 'rspec/core/rake_task'
require 'yaml'
require 'ansible_spec'
require 'cucumber/rake/task'
require 'dotenv'

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

Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = "--format pretty" # Any valid command line option can go here.
end
