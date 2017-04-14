require 'spec_helper'
require 'spec_helpers/config_helpers'

describe Inscriber::Inserter do
  let!(:database) do
    Inscriber::TestDatabase.setup do
      create_table :test_translations do
        primary_key :id
        integer :test_id
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

  let!(:translated_file) do
    File.open('test.fr.yml', 'w') { |f| f.write config.to_yaml }
  end

  let(:db) do
    database.connection.from(config["fr"].keys.first)
  end

  describe '.insert' do
    it 'should read the yml file and insert the data into the db' do
      Inscriber::Inserter.insert(database)
      query = { 
        :locale => config.keys.first, 
        :body => config["fr"]["test_translations"].first["body"]
      }
      expect(db.where(query).all.length).to be 1
      File.unlink('fr.test.yml')
    end
  end
end
