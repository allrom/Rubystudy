# Lesson3 (Railway)  Class Route
#
class Route
  def initialize(station_start, station_end)
    @station_start = station_start
    @station_end = station_end
    @in_route = [@station_start, @station_end]
  end

  def station_add(station)
    @in_route.insert(-2, station)
  end

  def station_remove(station)
    @in_route.delete(station) unless
      station == @in_route.first || station == @in_route.last
  end

  def station_list
    @in_route
  end

  def station_display
    puts "Stations:"
    @in_route.each { |station| puts station.title }
  end
end
