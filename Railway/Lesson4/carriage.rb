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

  def detach
    @detached = true
  end

  def attach(my_train_type, type)
    @detached = false if my_train_type == type
  end
end
