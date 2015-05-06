require 'spec_helper'

describe package('lcx-docker') do
  it { should be_installed }
end

describe service('docker') do
  it { should be_enabled   }
  it { should be_running   }
end

describe docker_container('ln-app') do
  it { should be_present }
end

describe docker_container('ln-app') do
  it { should be_running }
end
