require 'sequel'

module Inscriber
  class ConnectionString
    ADAPTER_STRINGS = { 
      mysql: "%{adapter}://%{username}:%{password}@%{host}/%{database_name}",
      postgres: "%{adapter}://%{username}:%{password}@%{host}/%{database_name}",
      sqlite: "%{adapter}://%{database_name}"
    }

    class << self
      def generate(options)
        ADAPTER_STRINGS[options[:adapter].to_sym] % options
      end
    end
  end
end
