Given(/^my redis server is available$/) do
  output=`vagrant up redis1`
end

And(/^I provision the redis server$/) do
  output=`vagrant provision redis1`
end

When(/^I get access to the redis server$/) do
  run_remote("ls")
end

Then(/^I expect it to have redis running$/) do
  run_remote("ps aux | grep redis")
end

def run_remote(command)
  `vagrant ssh redis1 -c "#{command}"`
end
