# Lesson6 (Railway)  Parent Class Carriage
#
class Carriage
  include Manufacturer
  include CheckValid

  attr_reader :number, :type, :detached, :volume_total, :volume_free
  attr_accessor :my_train_num

  def initialize(number, type, init_volume)
    @number = number
    @type = type
    @volume_free = init_volume
    @volume_total = init_volume
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

  def take_volume(unit)
    use_up!(unit) unless volume_free.zero?
  end

  def volume_used
    @volume_total - @volume_free
  end

  protected

  def validate!
    raise ArgumentError, "\tCarriage number can't be nil" if number.nil?
    raise ArgumentError, "\tEmpty (zero) num field is given" if number.zero?
    raise ArgumentError, "\tPositive number expected" if number.negative?
  end

  def use_up!(unit)
    if unit > volume_free
      @volume_free = 0
    else
      @volume_free -= unit
    end
  end
end
