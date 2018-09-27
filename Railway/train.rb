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
    speed >= slower ?  @speed -= slower : fullstop
  end

  def accelerate(faster)
    @speed += faster unless faster <= 0
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
    @stn_idx = @prev_idx = 0
    @next_idx = 1
    arrive
  end

  def route_limit?
    @stn_idx == @route.station_list.size - 1
  end

  def route_start?
    @stn_idx == 0
  end

  def previous_station
    @route.station_list[@prev_idx]
  end

  def actual_station
    @route.station_list[@stn_idx]
  end

  def next_station
    @route.station_list[@next_idx]
  end

  def arrive
    actual_station.train_arrive(self)
  end

  def departure
    actual_station.train_depart(self)
  end

  def go_forward
    unless route_limit?
      departure
      @prev_idx = @stn_idx
      @stn_idx += 1
      arrive
    end
    @next_idx = @stn_idx + 1 unless route_limit?
    actual_station
  end

  def go_back
    unless route_start?
      departure
      @prev_idx = @stn_idx
      @stn_idx -= 1
      arrive
    end
    @next_idx = @stn_idx - 1 unless route_start?
    actual_station
  end
end
