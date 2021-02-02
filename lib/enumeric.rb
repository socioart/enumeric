require "enumeric/version"

module Enumeric
  class Error < StandardError; end

  module_function
  # @param values [Hash<Symbol, Object>]
  def define(values)
    _values = values.each_with_object({}) {|(name, value), h|
      raise Error, "`#{name.inspect}` is not a Symbol" unless name.is_a?(Symbol)
      raise Error, "`#{value.inspect}` does not have `freeze` method" unless value.respond_to?(:freeze)

      h[name] = value.freeze
    }.freeze

    m = Module.new do
      @values = _values
      @values.each do |k, v|
        const_set(k, v)
      end

      class << self
        def include?(value)
          @values.values.include?(value)
        end

        def name(value)
          @values.key(value)
        end

        def values
          @values
        end
      end
    end

    m
  end
end
