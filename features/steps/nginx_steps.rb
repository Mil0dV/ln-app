Given(/^my nginx server is available$/) do
  run_simple("vagrant up #{ENV['APP_HOST']}", true, 120)
end

And(/^I provision the nginx server$/) do
  run_simple("vagrant provision #{ENV['APP_HOST']}", true, 120)
end

When(/^I get access to the nginx server$/) do
  run_remote("#{ENV['APP_HOST']}", "ls")
end

Then(/^I expect it to have nginx running$/) do
  run_remote("#{ENV['APP_HOST']}", "service nginx status")
end
