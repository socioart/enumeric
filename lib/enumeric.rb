require "enumeric/version"

module Enumeric
  class Error < StandardError; end

  module ModuleMethods
    def self.extended(klass)
      class << klass
        attr_reader :name_and_values
      end
    end

    def include?(value)
      values.include?(value)
    end

    def name(value)
      names_by_value[value]
    end

    def names
      @names ||= name_and_values.keys.freeze
    end

    def values
      @values ||= name_and_values.values.freeze
    end

    private
    def names_by_value
      @names_by_value ||= name_and_values.invert.freeze
    end
  end

  module_function
  # @param values [Hash<Symbol, Object>]
  # @return [Module]
  def define(name_and_values)
    name_and_values_frozen = name_and_values.each_with_object({}) {|(name, value), h|
      raise Error, "`#{name.inspect}` is not a Symbol" unless name.is_a?(Symbol)
      raise Error, "`#{value.inspect}` does not have `freeze` method" unless value.respond_to?(:freeze)

      h[name] = value.freeze
    }.freeze

    m = Module.new do
      @name_and_values = name_and_values_frozen
      @name_and_values.each do |k, v|
        const_set(k, v)
      end

      extend ModuleMethods
    end

    m
  end
end
