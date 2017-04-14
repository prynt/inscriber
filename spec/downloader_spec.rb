require 'spec_helper'

describe Inscriber::Downloader do
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

  describe '.download' do
    it 'should download a hash of the data in the db' do
      database.connection.from(:test_translations).insert(:body => 'test string', :test_id => 1, :locale => 'en')
      download = Inscriber::Downloader.new(database).download

      expect(download.keys).to include 'test_translations'
      expect(download['test_translations'].first["body"]).to eq 'test string'
      expect(download['test_translations'].first["test_id"]).to eq 1
    end
  end
end
