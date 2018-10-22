# Lesson4 (Railway) Cargo (Sub)Class Train
#
class CargoTrain < Train

  def initialize(number)
    super(number, :cargo)
  end
end
