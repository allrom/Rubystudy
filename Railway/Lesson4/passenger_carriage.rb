# Lesson4 (Railway) Passenger (Sub)Class Carriage
#
class PassengerCarriage < Carriage

  def initialize(number)
    super(number, :passenger)
  end
end
