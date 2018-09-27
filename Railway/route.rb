# Lesson3 (Railway)  Class Route
#
class Route
  def initialize(station_start, station_end)
    @in_route = [station_start, station_end]
  end

  def route_start
    @in_route.first
  end

  def route_end
    @in_route.last
  end

  def station_add(station)
    @in_route.insert(-2, station)
  end

  def boundary_station?(station)
    station == route_start || station == route_end
  end

  def station_remove(station)
    @in_route.delete(station) unless boundary_station?(station)
  end

  def station_list
    @in_route
  end

  def station_display
    puts "Stations:"
    @in_route.each { |station| puts station.title }
  end
end
