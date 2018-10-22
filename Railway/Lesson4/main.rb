# Lesson4 (Railway)  Main Menu Selection
#
require_relative 'train.rb'
require_relative 'passenger_train.rb'
require_relative 'cargo_train.rb'
require_relative 'carriage.rb'
require_relative 'passenger_carriage.rb'
require_relative 'cargo_carriage.rb'
require_relative 'route.rb'
require_relative 'station.rb'


class RailRoadSim
  MAIN_MENU = "\n * Selection Menu. Enter correct menu digit or any other to quit *\n"
  SUB_MENU  = "\n * Enter correct menu digit or any other to return *"

  def initialize
    puts "\t* RailRoad simulator *"
    @stations = []
    @trains = []
    @routes = []
    @carriages = []
  end

  def menu
    puts MAIN_MENU
    puts "
      1:  Create Station
      2:  Train Operations
      3:  Route Operations
      4:  Carriage Operations
      5:  Info"
    case gets.strip
    when "1"
      create_station
      self.menu
    when "2"
      train_operations
      self.menu
    when "3"
      route_operations
      self.menu
    when "4"
      carriage_operations
      self.menu
    when "5"
      info
      self.menu
    else
      puts "Exiting..."
    end
  end

  def create_station
    puts "\nEnter Station title:"
    st_title = gets.chomp.to_sym
    return  puts "\tTry again, empty field" if st_title.empty?
    @stations << Station.new(st_title)
    puts "\tStation #{st_title} is created"
  end

  def train_operations
    puts SUB_MENU
    puts "
      1:  Create Train
      2:  Assign Route to Train
      3:  Relocate Train"
    case gets.strip
    when "1"
      create_train
      self.train_operations
    when "2"
      assign_route
      self.train_operations
    when "3"
      reallocate_train
      self.train_operations
    else
      puts "Exiting up..."
      self.menu
    end
  end

  def create_train
    puts SUB_MENU
    puts "
      1:  Create Passenger Train
      2:  Create Cargo Train"
    case gets.strip
    when "1"
      create_passng_train
      self.train_operations
    when "2"
      create_cargo_train
      self.train_operations
    else
      puts "Exiting up..."
      self.menu
    end
  end

  def create_passng_train
    puts "\nEnter Train number:"
    train_num = gets.to_i
    return puts "\tTry again, empty field" if train_num.zero?
    @trains << PassengerTrain.new(train_num)
    puts "\tPassenger Train #{train_num} is created"
  end

  def create_cargo_train
    puts "\nEnter Train number:"
    train_num = gets.to_i
    return puts "\tTry again, empty field" if train_num.zero?
    @trains << CargoTrain.new(train_num)
    puts "\tCargo Train #{train_num} is created"
  end

  def assign_route
    unless routes.empty? || trains.empty?
      puts "\nEnter Route number:"
      route_num = gets.to_i
      return puts "\tTry again, empty field" if route_num.zero?
      route_assign = routes.detect { |route| route.number == route_num }
      return puts "\tUnknown Route" if route_assign.nil?
      puts "Enter Train number:"
      train_num = gets.to_i
      return puts "\tTry again, empty field" if train_num.zero?
      train_change = trains.detect { |train| train.number == train_num }
      return puts "\tUnknown Train" if train_change.nil?
      return puts "\tRoute is already here" if train_change.route&.number == route_assign.number
      train_change.route = route_assign
      puts "\tRoute #{route_num} is assigned"
    else
      puts "\tFirstly create at least one Route and/or Train"
      self.menu
    end
  end

  def reallocate_train
    unless routes.empty? || trains.empty?
      puts "\nEnter Train number:"
      train_num = gets.to_i
      return puts "\tTry again, empty field" if train_num.zero?
      train_realloc = trains.detect { |train| train.number == train_num }
      return puts "\tUnknown Train" if train_realloc.nil?
      return puts "\tRoute not anassigned" if train_realloc.route.nil?
      puts "This #{train_realloc.type.to_s} train is on route #{train_realloc.route.number}"
      puts SUB_MENU
      puts "
        1:  Train Go Forward
        2:  Train Go Reverse"
      case gets.strip
      when "1"
        train_realloc.go_forward
      when "2"
        train_realloc.go_back
      else
        puts "Exiting up..."
        self.train_operations
      end
      puts "Train is at: #{train_realloc.actual_station&.title}"
      puts "The next is: #{train_realloc.next_station&.title}"
      puts "The previous is: #{train_realloc.previous_station&.title}"
      self.train_operations
    else
      puts "\tFirstly create at least one Route and/or Train"
      self.menu
    end
  end

  def route_operations
    puts SUB_MENU
    puts "
      1:  Create Route
      2:  Assign Station to existent Route
      3:  Deassign Station from Route"
    case gets.strip
    when "1"
      create_route
      self.route_operations
    when "2"
      assign_station
      self.route_operations
    when "3"
      deassign_station
      self.route_operations
    else
      puts "Exiting up..."
      self.menu
    end
  end

  def create_route
    unless stations.size < 2
      puts "\nEnter Route number:"
      route_num = gets.to_i
      return puts "\tTry again, empty field" if route_num.zero?
      puts "Enter First Station title in route:"
      st_first = gets.chomp.to_sym
      return puts "\tTry again, empty field(s)" if st_first.empty?
      add_first = stations.detect { |station| station.title == st_first }
      return puts "\tUnknown Station" if add_first.nil?
      puts "Enter Last Station title in route:"
      st_last = gets.chomp.to_sym
      return puts "\tTry again, empty field(s)" if st_last.empty?
      add_last = stations.detect { |station| station.title == st_last }
      return puts "\tUnknown Station" if add_last.nil?
      @routes << Route.new(route_num, add_first, add_last)
      puts "\tRoute #{route_num} is created"
    else
      puts "\tNeeds at least two stations to create route"
      self.menu
    end
  end

  def assign_station
    puts "\nEnter Station title:"
    st_title = gets.chomp.to_sym
    return puts "\tTry again, empty field" if st_title.empty?
    st_assign = stations.detect { |station| station.title == st_title }
    return puts "\tUnknown Station" if st_assign.nil?
    puts "Enter Route number:"
    route_num = gets.to_i
    return puts "\tTry again, empty field" if route_num.zero?
    route_change = routes.detect { |route| route.number == route_num }
    return puts "\tRoute doesn't exist" if route_change.nil?
    return puts "\tStation is already here" if route_change.station_list.include?(st_assign)
    route_change.station_add(st_assign)
    puts "\tStation #{st_title} is added to route #{route_num}"
  end

  def deassign_station
    puts "\nEnter Station title:"
    st_title = gets.chomp.to_sym
    return puts "\tTry again, empty field" if st_title.empty?
    st_assign = stations.detect { |station| station.title == st_title }
    return puts "\tUnknown Station" if st_assign.nil?
    puts "Enter Route number:"
    route_num = gets.to_i
    return puts "\tTry again, empty field" if route_num.zero?
    route_change = routes.detect { |route| route.number == route_num }
    return puts "\tRoute doesn't exist" if route_change.nil?
    return puts "\tStation is not in this Route" unless route_change.station_list.include?(st_assign)
    return puts "\tStation is boundary" if route_change.boundary_station?(st_assign)
    return puts "\tTrain(s) is stopped on this staton" unless st_assign.train_list.empty?
    route_change.station_remove(st_assign)
    puts "\tStation #{st_title} is removed from Route #{route_num}"
  end

  def carriage_operations
    puts SUB_MENU
    puts "
      1:  Create Carriage
      2:  Attach Carriage to Train
      3:  Detach Carriage from Train"
    case gets.strip
    when "1"
      create_carriage
      self.carriage_operations
    when "2"
      attach
      self.carriage_operations
    when "3"
      detach
      self.carriage_operations
    else
      puts "Exiting up..."
      self.menu
    end
  end

  def create_carriage
    puts SUB_MENU
    puts "
      1:  Create Passenger Carriage
      2:  Create Cargo Carriage"
    case gets.strip
    when "1"
      create_passng_carr
      self.carriage_operations
    when "2"
      create_cargo_carr
      self.carriage_operations
    else
      puts "Exiting up..."
      self.menu
    end
  end

  def create_passng_carr
    puts "\nEnter Carriage number:"
    carr_num = gets.to_i
    return puts "\tTry again, empty field" if carr_num.zero?
    @carriages << PassengerCarriage.new(carr_num)
    puts "\tPassng Carriage #{carr_num} is created"
  end

  def create_cargo_carr
    puts "\nEnter Carriage number:"
    carr_num = gets.to_i
    return puts "\tTry again, empty field" if carr_num.zero?
    @carriages << CargoCarriage.new(carr_num)
    puts "\tCargo Carriage #{carr_num} is created"
  end

  def attach
    puts "\nCarriages are (if any):"
    @carriages.each.with_index(1) do |carr, index|
      print " #{index}\.   #{carr.number}  #{carr.type}"
      print ",  status: ", carr.detached ? "detached\n" : "attached\n"
    end
    puts SUB_MENU
    idx = gets.to_i
    return puts "\tTry again, empty field" if idx.zero?
    carr_relay = @carriages[idx - 1]
    return puts "\tUnknown Carriage" if carr_relay.nil?
    puts "\nEnter Train number:"
    train_num = gets.to_i
    return puts "\tTry again, empty field" if train_num.zero?
    train_change = trains.detect { |train| train.number == train_num }
    return puts "\tUnknown Train" if train_change.nil?
    puts "\tThis train is of type #{train_change.type}"
    return puts "\tCan't mix object types"unless train_change.type_match?(carr_relay)
    return puts "\tThis carriage is attached already" unless carr_relay.detached
    return puts "\tProhibited action - train is in motion" if train_change.not_stopped?
    train_change.carr_attach(carr_relay)
    puts "\tThis #{carr_relay.type.to_s} carriage is attached to train #{carr_relay.my_train_num}"
  end

  def detach
    puts "\nCarriages are (if any):"
    @carriages.each.with_index(1) do |carr, index|
      print " #{index}\.   #{carr.number}  #{carr.type}"
      print ",  status: ", carr.detached ? "detached\n" : "attached\n"
    end
    puts SUB_MENU
    idx = gets.to_i
    return puts "\tTry again, empty field" if idx.zero?
    carr_relay = @carriages[idx - 1]
    return puts "\tUnknown Carriage" if carr_relay.nil?
    return puts "\tThis carriage is detached already" if carr_relay.detached
    puts "\nEnter Train number:"
    train_num = gets.to_i
    return puts "\tTry again, empty field" if train_num.zero?
    train_change = trains.detect { |train| train.number == train_num }
    return puts "\tUnknown Train" if train_change.nil?
    return puts "\tProhibited action - train is in motion" if train_change.not_stopped?
    return puts "\tProhibited action - train has no carriages" if train_change.carriage_list.empty?
    train_change.carr_detach(carr_relay)
    puts "\tThis #{carr_relay.type.to_s} carriage is detached"
  end

  def info
    puts SUB_MENU
    puts "
      1:  Stations Info
      2:  Trains Info
      3:  Routes Info
      4:  Carriage Info"
    case gets.strip
    when "1"
      puts "\tAll of the stations, if any:"
      stations.each { |station| puts " #{station.title}   #{station} " }
      puts "\nEnter Station title for Train list or Enter to quit:"
      st_title = gets.chomp.to_sym
      return puts "\tEmpty field, exiting..." if st_title.empty?
      st_info = stations.detect { |station| station.title == st_title }
      return puts "\tUnknown Station" if st_info.nil?
      puts "\tTrain(s), if present:"
      st_info.train_list.each { |train| puts " #{train.number}   #{train}"}
      self.info
    when "2"
      puts "\tAll of the trains, if any:"
      trains.each do |train|
        print " #{train.number},  #{train.type}. \n"
        print " Train is on route: #{train.route&.number}.\n"
        print " Train has #{train.carriage_count} carriage(s): "
        train.carriage_list.each { |carr| print "#{carr.number} \> " }
        puts "\n ----------"
      end
      self.info
    when "3"
      puts "\tAll of the routes, if any:"
      routes.each do |route|
        print " #{route.number}  "
        route.station_list.each { |station| print " \* #{station.title}" }
      end
      self.info
    when "4"
      puts "\tCarriages are (if any):"
      @carriages.each.with_index(1) do |carr, index|
        puts " #{index}\.   #{carr.number}  #{carr.type}"
      end
      puts SUB_MENU
      idx = gets.to_i
      return puts "\tTry again, empty field" if idx.zero?
      carr_info = @carriages[idx - 1]
      return puts "\tUnknown Carriage" if carr_info.nil?
      print "\tThis #{carr_info.type.to_s} carriage is ",
        carr_info.detached ? "detached\n" : "attached to train #{carr_info.my_train_num}\n"
      self.info
    else
      puts "Exiting up..."
      self.menu
    end
  end

  def stations
    @stations
  end

  def trains
    @trains
  end

  def routes
    @routes
  end

  def carriages
    @carriages
  end
end
