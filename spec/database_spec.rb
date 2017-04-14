require 'spec_helper'
require 'spec_helpers/test_database'

describe Inscriber::Database do
  let!(:database) { Inscriber::TestDatabase.setup }

  describe '.connection' do
    it 'should return a connection to a db' do
      expect(database.connection).to be_a(Sequel::SQLite::Database)
    end
  end
end
