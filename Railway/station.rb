# Lesson3 (Railway)  Class Station
#
class Station
  attr_reader :title

  def initialize(title)
    @title = title
    @trains_at_station = []
  end

  def train_arrive(train)
    @trains_at_station << train
  end

  def train_depart(train)
    @trains_at_station.delete(train)
  end

  def train_list
    @trains_at_station
  end

  def train_display
    puts "Train numbers:"
    @trains_at_station.each { |s_train| puts s_train.number }
  end

  def train_type_display(type)
    type_count = 0
    @trains_at_station.each { |train| type_count += 1 if train.type == type }
    type_count
  end
end
