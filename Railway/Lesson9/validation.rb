# Lesson9 (Railway) Validation Module
#
module Validation
  def self.included(base)
    base.extend(ClassMethods)
    base.send(:include, InstanceMethods)
  end

  module ClassMethods
    VALD_TYPES = %w[presence format type]

    attr_writer :validation_types

    def validation_types
      @validation_types ||= []
    end

    VALD_TYPES.each do |vald_type|
      define_method "#{vald_type}".to_sym do |attr_check, *args|
        req_presence(attr_check) if vald_type == "presence"
        req_format(attr_check, args.first) if vald_type == "format"
        req_type(attr_check, args.first) if vald_type == "type"
      end
    end

    def req_presence(attr)
      raise ArgumentError, "Attribute can't be nil" if attr.nil?
      if attr.is_a?(String) && attr.empty?
        raise ArgumentError, "Attribute can't be empty string"
      end
      if attr.is_a?(Integer) && attr.zero?
        raise ArgumentError, "Attribute can't be zero"
      end
    end

    def req_format(attr, format)
      raise ArgumentError, "Attribute has a wrong format" unless attr =~ format
    end

    def req_type(attr, type)
      raise TypeError, "Attribute class mismatch" unless attr.is_a?(type)
    end

    def validate(attribute, validation_type, *args)
      send(validation_type, attribute, *args)
    end
  end

  module InstanceMethods
    def valid?
      validate!
      true
    rescue StandardError
      false
    end

    protected

    def validate!
      self.class.validation_types.each do |vald_type|
        attrs = instance_variable_get("@#{vald_type}_validation_attrs")
        attribute, *args = attrs
        self.class.validate(attribute, vald_type, *args)
      end
    end
  end
end
