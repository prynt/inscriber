require 'yaml'

module Inscriber
  class Config
    class << self
      def data
        path = ENV['INSCRIBER_CONFIG'] || 'config/inscriber.yml' 
        @data = symbolize_all_keys(YAML.load_file(path))
      end

      private

      def symbolize_all_keys(obj)
        case obj
        when Hash 
          obj.each_with_object({}){ |(k,v), h| h[k.to_sym] = symbolize_all_keys(v) }
        when Array
          obj.map{ |elem| symbolize_all_keys(elem) }
        else
          obj 
        end
      end
    end
  end
end
