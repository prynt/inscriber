module Inscriber
  class ConfigHelpers
    class << self
      def config
        {
          adapter: 'sqlite',
          host: 'localhost',
          database_name: 'test.sqlite',
          username: '',
          password: '',
          source_lang: 'en',
          file_name: 'test.yml',
          input_dir: '.',
          tables: [
            {
              name: 'test_translations',
              columns: ['body']
            }
          ],
          locales: [
            'fr'
          ]
        }
      end
    end
  end
end
