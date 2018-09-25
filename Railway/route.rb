# Lesson3 (Railway)  Class Route
#
class Route
  def initialize(station_start, station_end)
    @station_start = station_start
    @station_end = station_end
    @stations_in_route = []
  end

  def station_add(station)
    @stations_in_route << station
  end

  def station_remove(station)
    @stations_in_route.delete(station)
  end

  def station_list
    all_stations = [@station_start, @stations_in_route, @station_end].flatten!
    all_stations.each { |title| puts title }
  end
end
