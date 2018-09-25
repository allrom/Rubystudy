# Lesson3 (Railway)  Class Train
#
class Train
  attr_accessor :speed, :carriages
  attr_reader :type, :number

  def initialize(number, type, carriages)
    @number = number
    @type = type
    @carriages = carriages
    @stn_idx = 0
  end

  def brakes
    self.speed = 0
  end

  def carr_total
    @carriages
  end

  def carr_attach
    @carriages += 1 if speed == 0
  end

  def carr_detach
    @carriages -= 1 if speed == 0
  end

  def way_to_go(route)
    @route = route.station_list
    @stn_actual = @route.first
    puts "Actual station: #{@stn_actual}"
  end

  def go_forward
    @stn_idx += 1 if @stn_idx < @route.size - 1
    @stn_actual = @route.at(@stn_idx)
    puts "Actual station: #{@stn_actual}"
  end

  def go_back
    @stn_idx -= 1 unless @stn_idx == 0
    @stn_actual = @route.at(@stn_idx)
    puts "Actual station: #{@stn_actual}"
  end

  def stations_btw
    puts "Stations:"
    puts "Prev. #{@route.at(@stn_idx - 1)}," unless @stn_idx < 1
    puts "Actual #{@stn_actual},"
    puts "Next #{@route.at(@stn_idx + 1)}" unless @stn_actual == @route.last
  end
end
