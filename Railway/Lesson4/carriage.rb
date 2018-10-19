# Lesson4 (Railway)  Parent Class Carriage
#
class Carriage
  attr_reader :number, :type, :detached
  attr_accessor :my_train_num

  def initialize(number, type)
    @number = number
    @type = type
    @detached = true
  end

  def engaged
    attached!
  end

  def disengaged
    detached!
  end

  def status
    print "\tThis #{type.to_s} carriage is ",
      self.detached ? "detached\n" : "attached to train #{self.my_train_num}\n"
  end

  # These methods should be passed to subclasses
  # but shouldn't be called from "outside"
  # and change the carriage status directly

  protected

  def detached!
    @detached = true
  end

  def attached!
    @detached = false
  end
end
