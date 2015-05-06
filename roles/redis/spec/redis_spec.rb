require 'spec_helper'

describe service('redis') do
  it { should be_running   }
end

describe port(6379) do
  it { should be_listening }
end

describe file('/etc/redis/6379.conf') do
  it { should be_file }
end
