# Lesson4 (Railway) Cargo (Sub)Class Train
#
class CargoTrain < Train

  def initialize(number)
    super(number, :cargo)
  end

  # These methods belong only to instances,
  # constructed from this particular class
  # and should'n be called from "outside"

  private

  def carr_attach!(carriage)
    @carriages << carriage
    carriage.engaged
    carriage.my_train_num = self.number
    puts "\tThe carriage is being attached..."
  end

  def carr_detach!(carriage)
    @carriages.delete(carriage)
    carriage.disengaged
    puts "\tThe carriage is being detached..."
  end
end
