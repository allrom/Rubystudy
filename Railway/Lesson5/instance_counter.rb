# Lesson5 (Railway)  Instance Counter Module
#
module InstanceCounter
  def self.included(base)
    base.extend(ClassMethods)
    base.send(:include, InstanceMethods)
  end

  module ClassMethods
    attr_writer :count_instances

    def count_instances
      @count_instances ||= 0
    end

    def instances
      count_instances
    end
  end

  module InstanceMethods
    private

    def register_instance
      self.class.count_instances += 1
    end
  end
end
