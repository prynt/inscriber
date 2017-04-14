require 'spec_helper'
require 'spec_helpers/test_database'
require 'spec_helpers/config_helpers'
require 'tempfile'
require 'yaml'

describe Inscriber::Config do
  let!(:file) do
    file = Tempfile.new('inscriber.yml')
    file.write(YAML.dump(Inscriber::ConfigHelpers.config))
    file.rewind
    file
  end

  let!(:data) do
    ENV['INSCRIBER_CONFIG'] = "#{file.path}"
    Inscriber::Config.data
  end

  describe '.data' do
    it 'loads object from inscriber.yml' do
      expect(data[:adapter]).to eq('sqlite')  
      expect(data[:host]).to eq('localhost')  
      expect(data[:database_name]).to eq('test')  
      file.close
      file.unlink
    end
  end
end
