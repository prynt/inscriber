module Inscriber
  class Downloader
    include TableHelpers

    def initialize(database)
      @db          ||= connect_to_db(database)
      @database    = database
      @result_hash = Hash.new(0)
    end

    def download
      @database.tables.each do |table|
        @result_hash[table[:name]] = records_from_table(table[:name]).map do |record|
          generate_hash_from_record(record, table)
        end
      end
      @result_hash
    end

    private 

    def connect_to_db(database)
      database.connection
    end

    def records_from_table(table_name)
      @db.from(table_name).where(locale: @database.source_lang)
    end

    def generate_hash_from_record(record, table)
      record.select{ |k,v| table[:columns].include? k.to_s }
        .merge(original_column_name(table[:name]) => record[original_column_name(table[:name])])
        .inject({}){ |h, (k,v)| h[k.to_s] = v; h }.to_h
    end
  end
end
