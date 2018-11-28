# Lesson7 (Railway) Passenger (Sub)Class Carriage
#
class PassengerCarriage < Carriage

  def initialize(number, seats)
    super(number, :passenger, seats)
  end

  def take_volume(unit = 1)
    super(1)
  end
end
