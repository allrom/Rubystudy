# Lesson7 (Railway) Passenger (Sub)Class Carriage
#
class PassengerCarriage < Carriage
  def initialize(number, seats)
    super(number, :passenger, seats)
  end

  def take_volume(_unit)
    super(1)
  end
end
