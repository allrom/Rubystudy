# Lesson3 (Railway)  Class Station
#
class Station
  attr_reader :title

  def initialize(title)
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

  def train_display
    puts "Train numbers:"
    @trains.each { |s_train| puts s_train.number }
  end

  def train_type_count(type)
    @trains.count { |train| train.type == type }
  end
end
