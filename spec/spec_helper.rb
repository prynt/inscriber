require 'bundler/setup'
Bundler.setup

require 'rspec'
require 'sequel'
require 'sqlite3'
require 'inscriber'

require 'spec_helpers/test_database'

RSpec.configure do |config|
  config.before(:each) do
    Inscriber::TestDatabase.reset
  end
end
