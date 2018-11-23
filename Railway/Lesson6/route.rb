# Lesson6 (Railway)  Class Route
#
class Route
  include InstanceCounter
  include CheckValid

  attr_reader :number

  def initialize(number, station_start, station_end)
    @number = number
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
    station == route_start || station == route_end
  end

  def station_remove(station)
    @stations.delete(station) unless boundary_station?(station)
  end

  def station_list
    @stations
  end

  protected

  def validate!
    raise ArgumentError, "\tRoute number can't be nil" if number.nil?
    raise ArgumentError, "\tEmpty (zero) num field is given" if number.zero?
    raise ArgumentError, "\tPositive number expected" if number.negative?
    raise TypeError, "\tStation object expected" unless [route_start, route_end].all?(Station)
    raise TypeError, "\tInvalid route set (start = end)" if [route_start, route_end].uniq.count == 1
  end
end
