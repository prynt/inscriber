module Inscriber
  class Uploader
    include TableHelpers
    attr_accessor :database, :table, :records, :locale

    def initialize(opts)
      @database = opts[:database]
      @table    = opts[:table]
      @records  = opts[:records]
      @locale   = opts[:locale]
    end

    def upload
      records.each do |record|
        update_or_create_record(record)
      end
    end

    private

    def db_connection
      @db ||= database.connection
    end

    def db_from_table
      db_connection.from(table)
    end

    def original_column
      original_column_name(table)
    end

    def update_or_create_record(record)
      row = db_from_table.where(
        original_column => record[original_column.to_s],
        :locale => locale) 

      if row.empty?
        db_from_table.insert({
          locale: locale}
          .merge(created_at)
          .merge(updated_at)
          .merge(record))
      else
        row.update(record)
      end
    end

    def created_at
      return {} unless db_from_table.columns.include?(:created_at)
      { created_at: Time.now }
    end

    def updated_at 
      return {} unless db_from_table.columns.include?(:updated_at)
      { updated_at: Time.now }
    end
  end
end
