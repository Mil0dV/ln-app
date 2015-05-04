require 'aruba/cucumber'
require 'dotenv'

Before do
  @dirs = ["."]
end

Dotenv.load File.absolute_path('.env')
