# frozen_string_literal: true

require 'active_support'
require 'active_support/core_ext/string'
require 'ostruct'

module PostNordAPI
  class Base < OpenStruct
    def initialize(attributes)
      super to_ostruct(attributes)
    end

    def to_ostruct(obj)
      if obj.is_a?(Hash)
        OpenStruct.new(obj.map { |key, val| [key.to_s.underscore, to_ostruct(val)] }.to_h)
      elsif obj.is_a?(Array)
        obj.map { |o| to_ostruct(o) }
      else # Assumed to be a primitive value
        obj
      end
    end

    # Convert back to hash without table key, including nested structures
    def to_hash
      ostruct_to_hash(self)
    end

    private

    def ostruct_to_hash(object)
      case object
      when OpenStruct
        hash = object.to_h.reject { |k, _| k == :table }
        hash.transform_values { |value| ostruct_to_hash(value) }
      when Array
        object.map { |item| ostruct_to_hash(item) }
      when Hash
        object.transform_values { |value| ostruct_to_hash(value) }
      else
        object
      end
    end
  end
end
