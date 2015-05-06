require 'spec_helper'

describe package('haproxy') do
  it { should be_installed }
end

describe service('haproxy') do
  it { should be_enabled   }
  it { should be_running   }
end

describe port(80) do
  it { should be_listening }
end
