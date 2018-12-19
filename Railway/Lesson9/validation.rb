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
      arguments = {}
      validation_sets[validation_type] ||= []
      arguments[:attr_name] = attribute
      arguments[:options] = *args if args
      validation_sets[validation_type] << arguments
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

    def atype(attr, type)
      raise TypeError, "\"#{attr}\", class mismatch" unless attr.is_a?(type)
    end

    def validate!
      self.class.validation_sets.each do |vald_type, arguments|
        arguments.each do |argument|
          attr_check = instance_variable_get("@#{argument[:attr_name]}")
          if argument[:options].empty?
            send(vald_type, attr_check)
          else
            argument[:options].each { |option| send(vald_type, attr_check, option) }
          end
        end
      end
    end
  end
end
