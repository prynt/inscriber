module Inscriber
  class Database
    attr_accessor :adapter, :host, :port, :username, :password, :source_lang
    attr_accessor :output_dir, :input_dir, :file_name, :tables, :locales, :database_name

    DEFAULT_HOST = '127.0.0.1'
    DEFAULT_PORT = 5432

    def initialize(options={})
      @adapter       = options.fetch(:adapter, nil)
      @host          = options.fetch(:host, DEFAULT_HOST)
      @port          = options.fetch(:port, DEFAULT_PORT)
      @database_name = options.fetch(:database_name, nil)
      @username      = options.fetch(:username, '')
      @password      = options.fetch(:password, '')
      @source_lang   = options.fetch(:source_lang, 'en')
      @output_dir    = options.fetch(:output_dir, '.')
      @input_dir     = options.fetch(:input_dir, @output_dir)
      @file_name     = options.fetch(:file_name, 'translations')
      @tables        = options.fetch(:tables, nil)
      @locales       = options.fetch(:locales, nil)
    end

    def connection
      @connection ||= Sequel.connect(connection_string)
    end

    private

    def connection_string
      Inscriber::ConnectionString.generate(connection_opts)
    end

    def connection_opts
      { adapter: adapter, host: host, port: port, database_name: database_name, username: username, password: password }
    end
  end
end
