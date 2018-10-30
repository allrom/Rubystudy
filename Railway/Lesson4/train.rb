# Lesson4 (Railway)  Parent Class Train
#
class Train
  attr_reader :speed, :type, :number, :route

  def initialize(number, type)
    @number = number
    @type = type
    @carriages = []
    @speed = 0
  end

  def fullstop
    @speed = 0
  end

  def not_stopped?
    speed != 0
  end

  def slowdown(slower)
    speed >= slower ? @speed -= slower : fullstop
  end

  def accelerate(faster)
    faster.positive? ? @speed += faster : slowdown(faster.abs)
  end

  def carr_attach(carriage)
    carr_attach!(carriage) if attachable_carriage?(carriage)
  end

  def carr_detach!(carriage)
    deleted_carriage = @carriages.delete(carriage)
    return unless deleted_carriage
    deleted_carriage.detached!
    deleted_carriage.my_train_num = 0
  end

  def route=(route)
    @route = route
    @station_index = 0
    arrive
  end

  def go_forward
    if next_station
      departure
      @station_index += 1
      arrive
    end
  end

  def go_back
    if previous_station
      departure
      @station_index -= 1
      arrive
    end
  end

  def carriage_count
    @carriages.count
  end

  def carriage_list
    @carriages
  end

  def previous_station
    @route.station_list[@station_index - 1] if @station_index.positive?
  end

  def actual_station
    @route.station_list[@station_index]
  end

  def next_station
    @route.station_list[@station_index + 1]
  end

  # These methods should be passed to subclasses
  # but shouldn't be called from "outside"
  # and alter train location or "wrongly"
  # switch carriages

  protected

  def carr_attach!(carriage)
    @carriages << carriage
    carriage.attached!
    carriage.my_train_num = number
  end

  def arrive
    actual_station.train_arrive(self)
  end

  def departure
    actual_station.train_depart(self)
  end
end
