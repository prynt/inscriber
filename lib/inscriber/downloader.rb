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
        record_hash = Hash.new(0)
        records = records_from_table(table[:name]).all
        unless records.empty?
          records.each do |record|
            record_hash[record[:id]] = generate_hash_from_record(record, table)
          end
          @result_hash[table[:name]] = record_hash
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
        .merge(original_column_name(table[:name]).to_s => record[original_column_name(table[:name])])
        .inject({}){ |h, (k,v)| h[k.to_s] = v; h }.to_h
    end
  end
end
