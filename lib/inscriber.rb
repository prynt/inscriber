require 'inscriber/config'
require 'inscriber/connection_string'
require 'inscriber/database'
require 'inscriber/table_helper'
require 'inscriber/downloader'
require 'inscriber/uploader'
require 'inscriber/exporter'
require 'inscriber/inserter'

module Inscriber
  class << self
    def export 
      @config ||= Inscriber::Config.data
      @database ||= Inscriber::Database.new(@config)
      Inscriber::Exporter.export(@database)
    end

    def insert
      @config ||= Inscriber::Config.data
      @database ||= Inscriber::Database.new(@config)
      Inscriber::Inserter.insert(@database)
    end
  end
end
