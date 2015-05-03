Given(/^my nginx server is available$/) do
  output=`vagrant up app1`
end

And(/^I provision the nginx server$/) do
  output=`vagrant provision app1`
end

When(/^I get access to the nginx server$/) do
  run_remote("ls")
end

Then(/^I expect it to have nginx running$/) do
  run_remote("ps aux | grep nginx")
end

def run_remote(command)
  `vagrant ssh app1 -c "#{command}"`
end
