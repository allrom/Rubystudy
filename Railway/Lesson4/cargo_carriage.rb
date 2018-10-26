# Lesson4 (Railway) Cargo (Sub)Class Carriage
#
class CargoCarriage < Carriage

  def initialize(number)
    super(number, :cargo)
  end

  def attach(my_train_type)
    super(my_train_type, :cargo)
  end
end
