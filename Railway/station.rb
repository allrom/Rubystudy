# Lesson3 (Railway)  Class Station
#
class Station
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
    @trains_at_station.each { |s_train| puts "Train number: #{s_train.number}" }
  end

  def train_type_list
    passng_count = 0
    cargo_count = 0
    @trains_at_station.each do |s_train|
      puts "Train number #{s_train.number} is of type \"#{s_train.type}\"."
      s_train.type == 'passng' ? passng_count += 1 : cargo_count += 1
    end
    puts "Trains of type passng: #{passng_count}"
    puts "Trains of type cargo: #{cargo_count}"
  end
end
