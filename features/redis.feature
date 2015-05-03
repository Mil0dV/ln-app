Feature:
As a webmaster I need a DB/key-value store to be running so that my app can store state.

Background:
  Given my redis server is available
  And I provision the redis server

Scenario:
  When I get access to the redis server
  Then I expect it to have redis running
