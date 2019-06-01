require_relative 'db_connection'
require 'active_support/inflector'
require 'byebug'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    # ...
  @columns ||= DBConnection.execute2(<<-SQL)
    SELECT
      *
    FROM
      #{table_name}
  SQL

  @columns.first.map {|el| el.to_sym}

  end

  def self.finalize!
#  debugger
    # @columns.each do |ele|
    #   define_method('@attributes') do

    #   end
    # end

    self.columns.each do |col|
      define_method(col) do
        #scope of the instance. not class scope.
        @attributes[col]
      end
    end

    self.columns.each do |col|
      # debugger
      define_method(col.to_s + "=") do |val|
        #scope of the instance. not class scope.
        self.attributes[col] = val
      end
    end
    # debugger

    #  self.columns.each do |col|
    #   define_method(col+"=") do |input|
    #     @attributes[col] = input    
    #   end
    # end
  end

  def self.table_name=(table_name)
    # ...
    @table_name = table_name
  end

  def self.table_name
    # # ...
    name = self.to_s
    name[0] = name[0].downcase
  
    @table_name ||= name + 's'

  end

  def self.all
    # ...
  end

  def self.parse_all(results)
    # ...
  end

  def self.find(id)
    # ...
  end

  def initialize(params = {})
    # ...
    params.each do |k,v|
      send("#{k.to_sym}=", v)
    end
  end

  def attributes
    # ...
    @attributes ||= {}
  end

  def attribute_values
    # ...
  end

  def insert
    # ...
  end

  def update
    # ...
  end

  def save
    # ...
  end
end
