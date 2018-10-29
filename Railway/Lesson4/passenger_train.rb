# Lesson4 (Railway) Passenger (Sub)Class Train
#
class PassengerTrain < Train

  def initialize(number)
    super(number, :passenger)
  end

  def carr_attach(carriage)
    carr_attach!(carriage) if attachable_carriage?(carriage)
  end

  def carr_detach(carriage)
    carr_detach!(carriage) if attachable_carriage?(carriage) && carriage.my_train_num == number
  end
end
