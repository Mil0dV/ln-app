Feature:
As a webmaster I need a webserver to be running so that I can fulfill my goal in life.

Background:
  Given my server is available
  And I provision it

Scenario:
  When I get access to it
  Then I expect it to have nginx running
