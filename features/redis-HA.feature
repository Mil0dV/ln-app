Feature:
As a CTO I want to have Redis highly available so I can sleep well at night.

Background:
  Given that my redis master is available
  And that my redis slave is available
  And I provision them

Scenario:
  When I get access to the redis slave
  Then I expect replication to be enabled
  And I expect replication to function
  And I expect the redis port to be available on the loadbalancer
