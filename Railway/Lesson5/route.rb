# Lesson5 (Railway)  Class Route
#
class Route
  include InstanceCounter

  attr_reader :number

  def initialize(number, station_start, station_end)
    @number = number
    @stations = [station_start, station_end]
    register_instance
  end

  def route_start
    @stations.first
  end

  def route_end
    @stations.last
  end

  def station_add(station)
    @stations.insert(-2, station)
  end

  def boundary_station?(station)
    station == route_start || station == route_end
  end

  def station_remove(station)
    @stations.delete(station) unless boundary_station?(station)
  end

  def station_list
    @stations
  end

  def station_display
    puts "Stations:"
    @stations.each { |station| puts station.title }
  end
end
