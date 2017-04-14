require 'yaml'

module Inscriber
  class Inserter
    class << self
      def insert(database)
        database.locales.each do |locale|
          data = YAML.load_file("#{database.input_dir}/#{locale}.#{database.file_name}")
          data[locale].each do |table, records|
            opts = { database: database, table: table, records: records, locale: locale}
            upload_data_to_db(opts)
          end
        end
      end

      def upload_data_to_db(opts)
        Inscriber::Uploader.new(opts).upload
      end
    end
  end
end
