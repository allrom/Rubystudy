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
    @speed -= slower unless @speed - slower < 0
  end

  def accelerate(faster)
    @speed += faster
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
    @stn_idx = 0
    assigned_to = arrive
  end

  def actual_station(current_stn_index)
    @route.station_list[current_stn_index]
  end

  def arrive
    actual_station(@stn_idx).train_arrive(self)
  end

  def departure(dep_stn_index)
    actual_station(dep_stn_index).train_depart(self)
  end

  def go_forward
    @stn_idx += 1 if @stn_idx < @route.station_list.size - 1
    arrived_to = arrive
    left_from = departure(@stn_idx - 1)
    @actual = actual_station(@stn_idx)
  end

  def go_back
    @stn_idx -= 1 unless @stn_idx == 0
    arrived_to = arrive
    left_from = departure(@stn_idx + 1)
    @actual = actual_station(@stn_idx)
  end

  def stations_btw
    actual = actual_station(@stn_idx)
    follow = actual_station(@stn_idx + 1) unless actual == @route.station_list.last
    @stn_idx >= 1 ? previous = actual_station(@stn_idx - 1) : previous = follow
    @on_track = [previous, actual, follow].compact
  end

  def stations_btw_display
    puts "Stations-in-between:"
    stations_btw.each { |station| puts station.title }
  end
end
