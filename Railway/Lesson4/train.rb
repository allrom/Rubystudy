# Lesson4 (Railway)  Parent Class Train
#
class Train
  attr_reader :speed, :type, :number, :route

  def initialize(number, type)
    @number = number
    @type = type
    @carriages = []
    @speed = 0
  end

  def fullstop
    @speed = 0
  end

  def not_stopped?
    speed != 0
  end

  def slowdown(slower)
    speed >= slower ? @speed -= slower : fullstop
  end

  def accelerate(faster)
    faster.positive? ? @speed += faster : slowdown(faster.abs)
  end

  def carr_attach(carriage)
    return puts "\tCan't mix object types..."unless type_match?(carriage)
    return puts "\tThis carriage is attached already..." unless carriage.detached
    return puts "\tProhibited action - train is in motion..." if not_stopped?
    carr_attach!(carriage)
  end

  def carr_detach(carriage)
    return puts "\tProhibited action - train is in motion..." if not_stopped?
    return puts "\tProhibited action - train has no carriages..." if @carriages.empty?
    carr_detach!(carriage)
  end

  def route=(route)
    @route = route
    @station_index = 0
    arrive
  end

  def go_forward
    if next_station
      departure
      @station_index += 1
      arrive
    end
  end

  def go_back
    if previous_station
      departure
      @station_index -= 1
      arrive
    end
  end

  def carriage_count
    @carriages.count
  end

  def carriage_list
    @carriages
  end

  def status_pos
    puts "Train is at: #{actual_station&.title}"
    puts "The next is: #{next_station&.title}"
    puts "The previous is: #{previous_station&.title}"
  end

  def status_carr
    print " Train has #{carriage_count} carriage(s): "
    self.carriage_list.each { |carr| print "#{carr.number} \> " }
  end

  def status_route
    puts "This #{type.to_s} train is on route #{route.number}"
  end

  def type_match?(carriage)
    carriage.type == self.type
  end

  # These methods should be passed to subclasses
  # but shouldn't be called from "outside"
  # and display info or alter train location

  protected

  def previous_station
    @route.station_list[@station_index - 1] if @station_index.positive?
  end

  def actual_station
    @route.station_list[@station_index]
  end

  def next_station
    @route.station_list[@station_index + 1]
  end

  def arrive
    actual_station.train_arrive(self)
  end

  def departure
    actual_station.train_depart(self)
  end
end
