# Lesson7 (Railway)  Class Station
#
class Station
  include InstanceCounter
  include Validation

  attr_reader :title, :trains, :status

  STATION_TITLE_FORMAT = /^[\dA-Z]{3}$/

  validate :title, :presence
  validate :title, :type, String
  validate :title, :format, STATION_TITLE_FORMAT
  validate :status, :presence
  validate :status, :type, String

  @@existing_instances = []

  def self.all
    @@existing_instances
  end

  def initialize(title)
    @title = title
    @trains = []
    @status = 'NODE'
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
