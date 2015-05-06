Feature:
As a CTO I need a docker in my docker so that I still feel current.

Background:
  Given my app server is available
  And I provision the app server

Scenario:
  When I get access to the app server
  Then I expect it to have docker running
  And I expect it to run the app container
