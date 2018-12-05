# Lesson4 (Railway) Cargo (Sub)Class Carriage
#
class CargoCarriage < Carriage
  def initialize(number, capacity)
    super(number, :cargo, capacity)
  end
end
