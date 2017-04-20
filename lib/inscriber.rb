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
      begin
        @config ||= Inscriber::Config.data
        @database ||= Inscriber::Database.new(@config)
        Inscriber::Exporter.export(@database)
      rescue => e
        { status: false, error: e }
      end
    end

    def insert
      begin
        @config ||= Inscriber::Config.data
        @database ||= Inscriber::Database.new(@config)
        Inscriber::Inserter.insert(@database)
      rescue => e
        { status: false, error: e }
      end
    end
  end
end
