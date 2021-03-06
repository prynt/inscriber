require 'yaml'

module Inscriber
  class Inserter
    class << self
      include TableHelpers
      def insert(database)
        database.locales.each do |locale|
          file_path = "#{database.input_dir}/#{database.file_name}"
          if File.exist? "#{file_path}.#{locale}.yml"
            data = YAML.load_file("#{file_path}.#{locale}.yml")

            data[locale].each do |table, records|
              records_array = []
              records.each do |k,v|
                records_array << v.merge(original_column_name(table) => k)
              end
              opts = { database: database, table: table, records: records_array, locale: locale }
              upload_data_to_db(opts)
            end
          else
            { status: false, error: 'File not found' }
          end
        end
        { status: true } 
      end

      private

      def upload_data_to_db(opts)
        Inscriber::Uploader.new(opts).upload
      end
    end
  end
end
