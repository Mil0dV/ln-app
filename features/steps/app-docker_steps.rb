Given(/^my app server is available$/) do
  run_simple("vagrant up #{ENV['APP_HOST']}", true, 120)
end

Given(/^I provision the app server$/) do
  run_simple("ansible-playbook -i hosts/dev app-playbook.yml", true, 120)
end

When(/^I get access to the app server$/) do
  run_remote("#{ENV['APP_HOST']}", "ls")
end

Then(/^I expect it to have docker running$/) do
  run_remote("#{ENV['APP_HOST']}", 'service docker status')
end

Then(/^I expect it to run the app container$/) do
  run_remote("#{ENV['APP_HOST']}", "sudo docker ps ")
  assert_passing_with('ln-app')
end
