require 'byebug'
require_relative '02_searchable'
require 'active_support/inflector'

# Phase IIIa
class AssocOptions
  attr_accessor(
    :foreign_key,
    :class_name,
    :primary_key
  )

  def model_class
    # ...
  end

  def table_name
    # ...
  end
end

class BelongsToOptions < AssocOptions
  def initialize(name, options = {})
    @name = name
    options[:foreign_key] ||= (name.to_s.singularize + "_id").to_sym
    options[:primary_key] ||= :id
    options[:class_name] ||= name.capitalize
    # debugger
    @foreign_key, @primary_key = options[:foreign_key], options[:primary_key]
    @class_name = options[:class_name]
  end

  def model_class
    @class_name.to_s.constantize
  end

  def table_name
    (@class_name + "s").downcase
  end
end

class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})
    options[:foreign_key] ||= (self_class_name.to_s.downcase + "_id").to_sym
    options[:primary_key] ||= :id
    options[:class_name] ||= name.to_s.singularize.capitalize
    @foreign_key, @primary_key = options[:foreign_key], options[:primary_key]
    @class_name = options[:class_name]
    # ...
  end

  def model_class
    @class_name.constantize
  end

  def table_name
    (@class_name + "s").downcase
  end
end

module Associatable
  # Phase IIIb
  def belongs_to(name, options = {})
    options = BelongsToOptions.new(name, options)

    define_method(name) do
      # debugger
      key = self.send(options.foreign_key)
      target_model = options.model_class
      where_cond = Hash.new
      where_cond[options.primary_key.to_sym] = key
      result = target_model.where(where_cond).first
    end
    # ...
  end

  def has_many(name, options = {})
    options = HasManyOptions.new(name, self, options)

    define_method(name) do

      key = self.send(options.primary_key)
      target_model = options.model_class
      where_cond = Hash.new
      # debugger
      where_cond[options.foreign_key.to_sym] = key

      result = target_model.where(where_cond)

    end

    # ...
  end

  def assoc_options
    # Wait to implement this in Phase IVa. Modify `belongs_to`, too.
  end
end

class SQLObject
  extend Associatable
  # Mixin Associatable here...
end
