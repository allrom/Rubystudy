# Lesson4 (Railway) Cargo (Sub)Class Train
#
class CargoTrain < Train

  def initialize(number)
    super(number, :cargo)
  end

  def carr_attach(carriage)
    carr_attach!(carriage) if attachable_carriage?(carriage)
  end

  def carr_detach(carriage)
    carr_detach!(carriage) if attachable_carriage?(carriage) && carriage.my_train_num == number
  end
end
