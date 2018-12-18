# Lesson9 (Railway) Validation Module
#
module Validation
  def self.included(base)
    base.extend(ClassMethods)
    base.send(:include, InstanceMethods)
  end

  module ClassMethods
    def validation_sets
      @validation_sets ||= {}
    end

    def validate(attribute, validation_type, *args)
      validation_sets[validation_type] ||= []
      validation_sets[validation_type] << [attribute, *args]
    end
  end

  module InstanceMethods
    def presence(attr)
      raise ArgumentError, "Attribute can't be nil" if attr.nil?
      if attr.is_a?(String) && attr.empty?
        raise ArgumentError, "Attribute can't be empty string"
      end
      if attr.is_a?(Integer) && attr.zero?
        raise ArgumentError, "Attribute can't be zero"
      end
    end

    def format(attr, format)
      raise ArgumentError, "\"#{attr}\", wrong format" unless attr =~ format
    end

    def type(attr, type)
      raise TypeError, "\"#{attr}\", class mismatch" unless attr.is_a?(type)
    end

    def valid?
      validate!
      true
    rescue StandardError
      false
    end

    protected

    def validate!
      self.class.validation_sets.each do |vald_type, vald_set|
        vald_set.each do |arg|
          attr_check = instance_variable_get("@#{arg.first}")
          send(vald_type, attr_check) if method(vald_type).arity == 1
          send(vald_type, attr_check, arg.last) if method(vald_type).arity == 2
        end
      end
    end
  end
end
