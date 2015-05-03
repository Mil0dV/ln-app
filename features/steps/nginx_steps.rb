Given(/^my server is available$/) do
  output=`vagrant reload`
end

And(/^I provision it$/) do
  output=`vagrant provision`
end

When(/^I get access to it$/) do
  run_remote("ls")
end

Then(/^I expect it to have nginx running$/) do
  run_remote("ps aux | grep nginx")
end

def run_remote(command)
  `vagrant ssh app1 #{command}`
end
