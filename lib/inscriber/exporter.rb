module Inscriber
  class Exporter
    class << self
      def export(database)
        data = { "#{database.source_lang}" => download_from_db(database) }
        File.open("#{database.output_dir}/#{database.file_name}.#{database.source_lang}.yml", "w") { |f| f.write data.to_yaml }
        { status: true }
      end
      
      private

      def download_from_db(database)
        Inscriber::Downloader.new(database).download
      end
    end
  end
end
