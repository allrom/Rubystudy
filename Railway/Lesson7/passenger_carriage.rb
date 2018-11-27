# Lesson7 (Railway) Passenger (Sub)Class Carriage
#
class PassengerCarriage < Carriage
  attr_reader :seats_free, :seats_occupied

  def initialize(number, seats)
    @seats_free = seats
    @seats_occupied = 0
    super(number, :passenger)
  end

  def occupy_seat
    occupy! if seats_free.positive?
  end

  protected

  def occupy!
    @seats_free -= 1
    @seats_occupied += 1
  end
end
