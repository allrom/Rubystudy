# Lesson4 (Railway) Passenger (Sub)Class Carriage
#
class PassengerCarriage < Carriage

  def initialize(number)
    super(number, :passenger)
  end

  def attach(my_train_type)
    super(my_train_type, :passenger)
  end
end
