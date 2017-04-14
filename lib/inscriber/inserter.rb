require 'yaml'

module Inscriber
  class Inserter
    class << self
      def insert(database)
        database.locales.each do |locale|
          data = YAML.load_file("#{database.input_dir}/#{database.file_name}.#{locale}.yml")
          data[locale].each do |table, records|
            opts = { database: database, table: table, records: records, locale: locale}
            upload_data_to_db(opts)
          end
        end
      end

      private

      def upload_data_to_db(opts)
        Inscriber::Uploader.new(opts).upload
      end
    end
  end
end
