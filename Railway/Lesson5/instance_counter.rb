# Lesson5 (Railway)  Instance Counter Module
#
module InstanceCounter
  def self.included(classbase)
    classbase.extend(ClassMethods)
  end

  module ClassMethods
    def instances
      count_instances
    end
  end

  private

  def register_instance
    self.class.count_instances += 1
  end
end
