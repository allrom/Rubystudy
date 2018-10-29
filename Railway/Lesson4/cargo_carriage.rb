# Lesson4 (Railway) Cargo (Sub)Class Carriage
#
class CargoCarriage < Carriage

  def initialize(number)
    super(number, :cargo)
  end
end
