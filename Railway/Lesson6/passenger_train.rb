# Lesson4 (Railway) Passenger (Sub)Class Train
#
class PassengerTrain < Train

  def initialize(number)
    super(number, :passenger)
  end

  def attachable_carriage?(carriage)
    carriage.is_a?(PassengerCarriage)
  end
end
