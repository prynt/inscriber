require 'spec_helper'
require 'spec_helpers/config_helpers'

describe Inscriber::Uploader do
  let!(:database) do
    Inscriber::TestDatabase.setup do
      create_table :test_translations do
        primary_key :id
        string :test_id
        string :body
        string :locale
      end
    end
  end

  let!(:config) do
    {
      "fr" => {
        "test_translations" => [
          {
            "body" => "Chaîne de test",
            "test_id" => 1
          }
        ]
      }
    }
  end

  let(:db) do
    database.connection.from(config["fr"].keys.first)
  end

  describe '.upload' do
    it 'should upload the data to the database' do
      opts = { database: database, table: config["fr"].keys.first, records: config["fr"]["test_translations"], locale: "fr" }
      Inscriber::Uploader.new(opts).upload
      query = { 
        :locale => config.keys.first, 
        :body => config["fr"]["test_translations"].first["body"]
      }
      expect(db.where(query).all.length).to be 1
    end
  end
end
