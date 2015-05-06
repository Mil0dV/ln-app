Given(/^my loadbalancer is available$/) do
  run_simple("vagrant up #{ENV['LB']}", true, 120)
end

Given(/^I provision the loadbalancer$/) do
  run_simple("ansible-playbook -i hosts/dev lb-playbook.yml", true, 120)
end

When(/^I get access to the loadbalancer$/) do
  run_remote("#{ENV['LB']}", "ls")
end

Then(/^I expect it to have haproxy running$/) do
  run_remote("#{ENV['LB']}", "service haproxy status")
end

Then(/^I expect it to have active backends$/) do
  run_remote("#{ENV['LB']}", 'echo "show stat" | sudo nc -U /var/lib/haproxy/stats | cut -d"," -f 1,18 | grep ln-app')
  assert_passing_with('UP')
end
