require_relative 'db_connection'
require_relative 'associatable'
require 'active_support/inflector'

class SQLObject
  def self.columns
    return @columns if @columns
    cols = DBConnection.execute2(<<-SQL).first
      SELECT
        *
      FROM
        #{self.table_name}
    SQL
    cols.map! { |col| col.to_sym }
    @columns = cols
  end

  def self.finalize!
    self.columns.each do |attr_name|
      define_method(attr_name) do
        self.attributes[attr_name]
      end

      define_method("#{attr_name}=") do |value|
        self.attributes[attr_name] = value
      end
    end

  end


  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name || self.name.underscore.pluralize
  end

  def self.all
    results = DBConnection.execute(<<-SQL)
      SELECT
        *
      FROM
        #{self.table_name}
    SQL
    self.parse_all(results)
  end

  def self.parse_all(results)
    results.map { |result| self.new(result) }
  end

  def self.where(params)
    where_line = params.keys.map { |key| "#{key} = ?"}.join(" AND ")
    vals = params.values
    result = DBConnection.execute(<<-SQL, *vals)
      SELECT
        *
      FROM
        #{table_name}
      WHERE
        #{where_line}
    SQL

    parse_all(result)
  end

  def self.find(id)
    results = DBConnection.execute(<<-SQL, id)
      SELECT
        *
      FROM
        #{self.table_name}
      WHERE
        #{self.table_name}.id = ?
    SQL
    parse_all(results).first
  end

  def initialize(params = {})
    params.each do |attribute_name, value|
      attribute_name = attribute_name.to_sym
      if self.class.columns.include?(attribute_name)
        self.send("#{attribute_name}=", value)
      else
        raise "unknown attribute '#{attribute_name}'"
      end
    end
  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    self.class.columns.map { |attr| self.send(attr) }
  end

  def insert
    columns = self.class.columns.drop(1)
    column_names = columns.map(&:to_s).join(", ")
    question_marks = (['?'] * columns.count).join(", ")

    DBConnection.execute(<<-SQL, *attribute_values.drop(1))
      INSERT INTO
        #{self.class.table_name} (#{column_names})
      VALUES
        (#{question_marks})
    SQL
    self.id = DBConnection.last_insert_row_id
  end

  def update
    columns = self.class.columns.drop(1)
    cols = columns.map do |col|
      "#{col.to_s} = ?"
    end
    cols = cols.join(", ")

    DBConnection.execute(<<-SQL, *attribute_values.drop(1), id)
      UPDATE
        #{self.class.table_name}
      SET
        #{cols}
      WHERE
        #{self.class.table_name}.id = ?
    SQL
  end

  def save
    id.nil? ? insert : update
  end
end
