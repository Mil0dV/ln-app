When(/^I get access to the webserver$/) do
  run 'curl -i -s http://192.168.33.21'
end

Then (/^the http status code should be 200$/) do
  assert_passing_with('HTTP/1.1 200')
end

And (/^I expect it to host lamernews$/) do
  assert_passing_with('lame')
end
