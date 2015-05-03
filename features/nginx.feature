Feature:
As a webmaster I need a webserver to be running so that I can fulfill my goal in life.

Background:
  Given my nginx server is available
  And I provision the nginx server

Scenario:
  When I get access to the nginx server
  Then I expect it to have nginx running
