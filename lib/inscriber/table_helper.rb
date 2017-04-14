module Inscriber
  module TableHelpers
    def original_table_name(table_name)
      table_name.sub(/_translations\z/, '')
    end

    def original_column_name(table_name)
      "#{original_table_name(table_name)}_id".to_sym
    end
  end
end
