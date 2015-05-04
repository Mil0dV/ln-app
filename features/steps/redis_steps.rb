Given(/^my redis server is available$/) do
  run_simple("vagrant up #{ENV['REDIS_HOST']}", true, 120)
end

And(/^I provision the redis server$/) do
  run_simple("vagrant provision #{ENV['REDIS_HOST']}", true, 120)
end

When(/^I get access to the redis server$/) do
  run_remote("#{ENV['REDIS_HOST']}", "ls")
end

Then(/^I expect it to have redis running$/) do
  run_remote("#{ENV['REDIS_HOST']}", "service redis_6379 status")
end
