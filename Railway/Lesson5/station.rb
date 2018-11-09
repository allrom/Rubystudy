# Lesson5 (Railway)  Class Station
#
class Station
  @existing_instances = []
  @count_instances = 0

  class << self
    attr_reader :existing_instances
    attr_accessor :count_instances

    def all
      existing_instances.each { |station| puts "#{station}, #{station.title}" }
    end
  end

  include InstanceCounter

  attr_reader :title

  def initialize(title)
    self.class.existing_instances << self
    register_instance
    @title = title
    @trains = []
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

  def train_display
    puts "Train numbers:"
    @trains.each { |s_train| puts s_train.number }
  end

  def train_type_count(type)
    @trains.count { |train| train.type == type }
  end
end
