# Lesson4 (Railway) Cargo (Sub)Class Train
#
class CargoTrain < Train

  def initialize(number)
    register_instance
    super(number, :cargo)
  end

  def attachable_carriage?(carriage)
    carriage.is_a?(CargoCarriage)
  end
end
