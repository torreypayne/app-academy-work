require_relative 'db_connection'
require_relative '01_sql_object'
require 'byebug'

module Searchable
  def where(params)
    # debugger

    where_line = params.keys.map { |key| "#{key} = ?" }.join('AND ')
    the_values = params.values
    result = DBConnection.execute(<<-SQL, *the_values)
      SELECT *
      FROM #{self.table_name}
      WHERE #{where_line}
    SQL
    result.each.map { |result| self.new(result) }

    # ...
  end
end

class SQLObject
  extend Searchable
  # Mixin Searchable here...
end
