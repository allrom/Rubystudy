# Lesson3 (Railway)  Class Train
#
class Train
  attr_reader :speed, :carriages, :type, :number

  def initialize(number, type, carriages)
    @number = number
    @type = type
    @carriages = carriages
  end

  def fullstop
    @speed = 0
  end

  def slowdown(slower)
    speed >= slower ? @speed -= slower : fullstop
  end

  def accelerate(faster)
    faster.positive? ? @speed += faster : @speed = slowdown(faster.abs)
  end

  def carr_total
    @carriages
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
    @next_station = @route.station_list[1]
    arrive
  end

  def previous_station
    @previous_station
  end

  def actual_station
    @route.station_list[@station_index]
  end

  def next_station
    @next_station
  end

  def arrive
    actual_station.train_arrive(self)
  end

  def departure
    actual_station.train_depart(self)
    @previous_station = actual_station
  end

  def go_forward
    unless actual_station == @route.route_end
      departure
      @station_index += 1
      arrive
      @next_station = @route.station_list[@station_index + 1] unless
        @route.station_list[@station_index + 1].nil?
    end
  end

  def go_back
    unless actual_station == @route.route_start
      departure
      @station_index -= 1
      arrive
      @next_station = @route.station_list[@station_index - 1] unless (@station_index - 1).negative?
    end
  end
end
