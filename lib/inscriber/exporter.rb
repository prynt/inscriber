module Inscriber
  class Exporter
    class << self
      def export(database)
        begin
          data = { "#{database.source_lang}" => download_from_db(database) }
          File.open("#{database.output_dir}/#{database.file_name}", "w") { |f| f.write data.to_yaml }
          { status: true }
        rescue => e
          { status: false, error: e }
        end
      end
      
      private

      def download_from_db(database)
        Inscriber::Downloader.new(database).download
      end
    end
  end
end
