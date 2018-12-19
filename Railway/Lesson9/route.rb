# Lesson6 (Railway)  Class Route
#
class Route
  include InstanceCounter
  include Validation

  attr_reader :number, :station_start, :station_end

  validate :number, :presence
  validate :station_start, :atype, Station
  validate :station_end, :atype, Station

  def initialize(number, station_start, station_end)
    @number = number
    @station_start = station_start
    @station_end = station_end
    @stations = [station_start, station_end]
    validate!
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
    [route_start, route_end].include?(station)
  end

  def station_remove(station)
    @stations.delete(station) unless boundary_station?(station)
  end

  def station_list
    @stations
  end
end
