# Lesson4 (Railway) Cargo (Sub)Class Carriage
#
class CargoCarriage < Carriage
  attr_reader :capacity_free, :capacity_used

  def initialize(number, capacity)
    @capacity_free = capacity
    @capacity_used = 0
    super(number, :cargo)
  end

  def use_capacity(capacity)
    use_up!(capacity) if capacity_free.positive?
  end

  protected

  def use_up!(capacity)
    if capacity > capacity_free
      @capacity_used += @capacity_free
      @capacity_free = 0
    else
      @capacity_free -= capacity
      @capacity_used += capacity
    end
  end
end
