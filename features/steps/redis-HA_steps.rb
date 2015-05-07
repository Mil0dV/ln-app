Given(/^that my redis master is available$/) do
  run_simple("vagrant up #{ENV['REDIS_MASTER']}", true, 120)
end

Given(/^that my redis slave is available$/) do
  run_simple("vagrant up #{ENV['REDIS_SLAVE']}", true, 120)
end

Given(/^I provision them$/) do
  run_simple("ansible-playbook -i hosts/dev redis-playbook.yml", true, 120)
end

When(/^I get access to the redis slave$/) do
  run_remote("#{ENV['REDIS_SLAVE']}", "ls")
end

Then(/^I expect replication to be enabled$/) do
  run_remote("#{ENV['REDIS_SLAVE']}", "awk '/slaveof/ && /6379/' /etc/redis/6379.conf")
  assert_passing_with('slaveof')
end

Then(/^I expect replication to function$/) do
  run_remote("#{ENV['REDIS_SLAVE']}", "redis-cli INFO | grep 'master_link_status:up'")
  assert_passing_with('online')
end

Then(/^I expect the redis port to be available on the loadbalancer$/) do
  pending # Write code here that turns the phrase above into concrete actions
end
