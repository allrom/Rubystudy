# Lesson5 (Railway)  Class Station
#
class Station
  include InstanceCounter

  attr_reader :title

  @@existing_instances = []

  def self.all
    @@existing_instances
  end

  def initialize(title)
    @title = title
    @trains = []
    @@existing_instances << self
    register_instance
  end

  def train_arrive(train)
    @trains << train
  end

  def train_depart(train)
    @trains.delete(train)
  end

  def train_list
    @trains
  end

  def train_stopped_here?
    !train_list.empty?
  end

  def train_type_count(type)
    @trains.count { |train| train.type == type }
  end
end
