require 'spec_helper'

describe Inscriber::ConnectionString do
  let!(:config) { Inscriber::ConfigHelpers.config }
  describe '.generate' do
    it 'returns mysql string when mysql adapter' do
      config[:adapter] = 'mysql'
      expect(Inscriber::ConnectionString.generate(config)).to be_a String
    end
    it 'returns postgres string when postgres adapter' do
      config[:adapter] = 'postgres'
      expect(Inscriber::ConnectionString.generate(config)).to be_a String
    end
    it 'returns sqlite string when sqlite adapter' do
      config[:adapter] = 'sqlite'
      expect(Inscriber::ConnectionString.generate(config)).to be_a String
    end
  end
end
