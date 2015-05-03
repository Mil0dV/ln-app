require 'spec_helper'

# todo
# describe package('redis') do
#   it { should be_installed }
# end

describe service('redis') do
  it { should be_running   }
end

describe port(6379) do
  it { should be_listening }
end

describe file('/etc/redis/6379.conf') do
  it { should be_file }
  # todo
  # it { should contain "worker_connections  1024;" }
end
