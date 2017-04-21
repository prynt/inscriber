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
        "test_translations" => { 
          1 => {
            "body" => "Chaîne de test"
          }
        }
      }
    }
  end

  let! :file do
    database.connection.from(:test_translations).insert(:body => 'test string', :test_id => 1, :locale => 'en')
    Inscriber::Exporter.export(database)
    "#{database.file_name}.#{database.source_lang}.yml"
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
        :body => config["fr"]["test_translations"].values.first["body"]
      }
      expect(db.where(query).all.length).to be 1
      File.unlink('test.fr.yml')
      File.unlink('test.en.yml')
    end
  end
end
