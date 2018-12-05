# Lesson7 (Railway)  Parent Class Train
#
class Train
  include InstanceCounter
  include Manufacturer
  include CheckValid

  attr_reader :speed, :type, :number, :route, :carriages

  TRAIN_NUMBER_FORMAT = /^[\da-z]{3}-?[\da-z]{2}$/i.freeze

  @@existing_instances = {}

  def self.find(number)
    @@existing_instances[number]
  end

  def initialize(number, type)
    @number = number
    @type = type
    @carriages = []
    @speed = 0
    validate!
    @@existing_instances[number] = self
    register_instance
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
    carr_attach!(carriage) if attachable_carriage?(carriage)
  end

  def carr_detach!(carriage)
    deleted_carriage = @carriages.delete(carriage)
    return unless deleted_carriage

    deleted_carriage.detached!
    deleted_carriage.my_train_num = 0
  end

  def route=(route)
    @route = route
    @station_index = 0
    arrive
  end

  def go_forward
    return unless next_station

    departure
    @station_index += 1
    arrive
  end

  def go_back
    return unless previous_station

    departure
    @station_index -= 1
    arrive
  end

  def carriage_count
    @carriages.count
  end

  def carriages_avail
    carriages.each { |carrg| yield(carrg) }
  end

  def previous_station
    @route.station_list[@station_index - 1] if @station_index.positive?
  end

  def actual_station
    @route.station_list[@station_index]
  end

  def next_station
    @route.station_list[@station_index + 1]
  end

  # These methods should be passed to subclasses
  # but shouldn't be called from "outside"

  protected

  def carr_attach!(carriage)
    @carriages << carriage
    carriage.attached!
    carriage.my_train_num = number
  end

  def arrive
    actual_station.train_arrive(self)
  end

  def departure
    actual_station.train_depart(self)
  end

  def validate!
    raise ArgumentError, "\tTrain number can't be nil" if number.nil?
    raise ArgumentError, "\tEmpty string field is given" if number.empty?
    raise ArgumentError, "\tNumber field in wrong format is given"\
      unless number =~ TRAIN_NUMBER_FORMAT
  end
end
