require 'byebug'
require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    raw_data = DBConnection.execute2(<<-SQL)
      SELECT
        *
      FROM
        #{table_name}
      SQL
      columns = raw_data.first.inject([]) { |arr, data| arr << data.to_sym }
      columns.each do |col|
        define_method((col.to_s + "=").to_sym) do |arg|
          # instance_variable_set("@#{col}", arg)
          attributes[col] = arg
        end

        define_method(col) do
          attributes[col]
        end
      end

      columns
    # ...
  end

  def self.finalize!
  end

  def self.table_name=(table_name = self.tableize)
    instance_variable_set("@table_name", table_name)
    # ...
  end

  def self.table_name
    table_name = instance_variable_get("@table_name") || self.to_s.tableize
    # ...
  end

  def self.all
    results = DBConnection.execute(<<-SQL)
      SELECT *
      FROM #{self.table_name}
      SQL
      p results
      parse_all(results)
    # ...
  end

  def self.parse_all(results)
    results.map { |new_obj| self.new(new_obj) }
    # ...
  end

  def self.find(id)
    result = DBConnection.execute(<<-SQL, id)
      SELECT *
      FROM #{self.table_name}
      WHERE id = ?
      SQL
      return nil if result.empty?
      self.new(result.first)
    # ...
  end

  def initialize(params = {})
    params.keys.each do |attribute|
      symbol = attribute.to_sym
      # p symbol
      error = "unknown attribute '#{attribute}'"
      raise Exception.new error if !self.class.columns.include?(symbol)
      setter = (attribute.to_s + "=" ).to_sym
      @name = params[attribute]
      send(setter, params[attribute])

    end    # ...
  end

  def attributes
    @attributes ||= {}
    # ...
  end

  def attribute_values
    self.class.columns.map { |att| self.send(att) }

    # ...
  end

  def insert
    col_names = self.class.columns.join(', ')
    question_marks = (["?"] * self.class.columns.size).join(', ')
    the_values = attribute_values
    # byebug
    DBConnection.execute(<<-SQL, *the_values)
      INSERT INTO #{self.class.table_name} (#{col_names})
      VALUES (#{question_marks})
      SQL

    self.id = DBConnection.last_insert_row_id
    # ...
  end

  def update
    the_set = self.class.columns.map { |att| "#{att} = ?" }.join(', ')
    the_values = attribute_values
    DBConnection.execute(<<-SQL, *the_values, id)
      UPDATE #{self.class.table_name}
      SET #{the_set}
      WHERE id = ?
      SQL
    # ...
  end

  def save
    if id.nil?
      insert
    else
      update
    end
    # ...
  end
end
