# Lesson9 (Railway) Accessor Module
#
module Accessors
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def accessors
      @@accessors ||= {}
    end

    def attr_accessor_with_history(*acsr_keys)
      acsr_keys.each do |acsr_key|
        accessors[acsr_key.to_sym] ||= []
        define_method acsr_key.to_sym do
          instance_variable_get("@#{acsr_key}")
        end
        define_method "#{acsr_key}=".to_sym do |acsr_value|
          instance_variable_set("@#{acsr_key}", acsr_value)
          self.class.accessors[acsr_key.to_sym] << acsr_value
        end
        define_method "#{acsr_key}_history",
          -> { self.class.accessors[acsr_key.to_sym] }
      end
    end

    def strong_attr_accessor(attr_check, attr_class)
      define_method attr_check.to_sym do
        instance_variable_get("@#{attr_check}")
      end
      define_method "#{attr_check}=".to_sym do |attr_value|
        raise TypeError, 'Wrong attr type' unless attr_value.is_a?(attr_class)

        instance_variable_set("@#{attr_check}", attr_value)
      end
    end
  end
end
