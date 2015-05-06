Feature:
As a CEO I want a cluster of app nodes so that my site can handle my TV appearance.

Background:
  Given my loadbalancer is available
  And I provision the loadbalancer

Scenario:
  When I get access to the loadbalancer
  Then I expect it to have haproxy running
  And I expect it to have active backends
