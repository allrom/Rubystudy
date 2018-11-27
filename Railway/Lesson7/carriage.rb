# Lesson6 (Railway)  Parent Class Carriage
#
class Carriage
  include Manufacturer
  include CheckValid

  attr_reader :number, :type, :detached
  attr_accessor :my_train_num

  def initialize(number, type)
    @number = number
    @type = type
    @detached = true
    validate!
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

  protected

  def validate!
    raise ArgumentError, "\tCarriage number can't be nil" if number.nil?
    raise ArgumentError, "\tEmpty (zero) num field is given" if number.zero?
    raise ArgumentError, "\tPositive number expected" if number.negative?
  end
end
