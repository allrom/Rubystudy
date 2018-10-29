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

  def detached?
    @detached
  end

  def attached?
    !detached
  end

  def detached!
    @detached = true
  end

  def attached!
    @detached = false
  end
end
