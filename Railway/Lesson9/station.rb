# Lesson7 (Railway)  Class Station
#
class Station
  include InstanceCounter
  include Validation

  attr_reader :title, :trains
  validation_types << :presence << :type << :format

  STATION_TITLE_FORMAT = /^[\dA-Z]{3}$/

  @@existing_instances = []

  def self.all
    @@existing_instances
  end

  def initialize(title)
    @title = title
    @trains = []
    @presence_validation_attrs = *title
    @type_validation_attrs = *title, String
    @format_validation_attrs = *title, STATION_TITLE_FORMAT
    validate!
    @@existing_instances << self
    register_instance
  end

  def train_arrive(train)
    @trains << train
  end

  def train_depart(train)
    @trains.delete(train)
  end

  def train_stopped_here?
    !trains.empty?
  end

  def train_type_count(type)
    @trains.count { |train| train.type == type }
  end

  def trains_avail
    trains.each { |train| yield(train) }
  end
end
