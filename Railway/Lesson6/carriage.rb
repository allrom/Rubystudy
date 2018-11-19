# Lesson6 (Railway)  Parent Class Carriage
#
class Carriage
  include Manufacturer
  include ArgsCheck

  attr_reader :number, :type, :detached
  attr_accessor :my_train_num

  def initialize(number, type)
    validate_num!(number)
    @number = number
    @type = type
    @detached = true
  end

  def valid?
    validate_num!(number)
    true
  rescue
    false
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
