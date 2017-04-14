require 'sequel'
require 'rspec'
require 'spec_helpers/config_helpers'

module Inscriber
  # The TestDatabase is responsible for creating a SQLite database with tables and columns for testing.
  # It is dumped after every example. To create a database, use the following format:
  #
  # Inscriber::TestDatabase.setup do
  #   create_table :test do
  #     primary_key :id
  #     string :body
  #     integer :test_app_id
  #   end
  # end
  #
  # Inscriber::TestDatabase.setup will return an instance of Inscriber::Database, which can be used for testing:
  # database = Inscriber::TestDatabase.setup
  # it 'should do something' do
  #   Inscriber::Downloader.new(database).download
  # end
  #
  class TestDatabase
    class << self
      def setup(&block)
        self_config = new.tap do |config|
          config.instance_eval(&block) if block
        end
        self_config.database
      end

      def reset
        location = "./#{Inscriber::ConfigHelpers.config[:database_name]}"
        File.unlink(location) if File.exists?(location)
      end
    end

    attr_accessor :database

    def initialize
      @database ||= Inscriber::Database.new(Inscriber::ConfigHelpers.config) 
    end

    def db_connection
      database.connection
    end

    def create_table(name, &block)
      opts = { name: name, database: database }
      TableCreator.new(opts).setup(&block)
    end
  end

  class TableCreator
    attr_accessor :name, :database

    def initialize(opts)
      @name     = opts[:name]
      @database = opts[:database]
    end

    def setup(&block)
      db_connection.create_table(name) { instance_eval &block }
    end

    private

    def db_connection
      database.connection
    end
  end
end

RSpec.configure do |config|
  config.around(:each) do |example|
    Inscriber::TestDatabase.reset
    example.run
  end
end
