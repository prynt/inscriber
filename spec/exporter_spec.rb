require 'spec_helper'

describe Inscriber::Exporter do
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

  let :file do
    database.connection.from(:test_translations).insert(:body => 'test string', :test_id => 1, :locale => 'en')
    Inscriber::Exporter.export(database)
    "#{database.file_name}.yml"
  end

  describe '.export' do
    let!(:data) { YAML.load_file(file) }

    it 'should create a yml file from the downloaded data' do
      expect(File).to exist(file) 
    end

    it 'should have the data in the yml file' do
      expect(data.has_key? "en").to be true
      expect(data["en"].has_key? "test_translations").to be true
      expect(data["en"]["test_translations"].values.first["body"]).to eq 'test string'
      File.unlink(file)
    end
  end
end
