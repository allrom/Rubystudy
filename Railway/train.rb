# Lesson3 (Railway)  Class Train
#
class Train
  attr_reader :speed, :carriages, :type, :number

  def initialize(number, type, carriages)
    @number = number
    @type = type
    @carriages = carriages
    @speed = 0
  end

  def fullstop
    @speed = 0
  end

  def slowdown(slower)
    speed >= slower ? @speed -= slower : fullstop
  end

  def accelerate(faster)
    faster.positive? ? @speed += faster : slowdown(faster.abs)
  end

  def carr_attach
    @carriages += 1 if speed == 0
  end

  def carr_detach
    @carriages -= 1 if speed == 0 && @carriages > 0
  end

  def route=(route)
    @route = route
    @station_index = 0
    arrive
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

  def arrive
    actual_station.train_arrive(self)
  end

  def departure
    actual_station.train_depart(self)
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
end
