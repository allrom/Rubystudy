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

puts "\t* RailRoad simulator *"


class RailRoadSim

  def initialize
    @created_stations = []
    @created_trains = []
    @created_routes = []
    @created_carriages = []
  end

  def menu
    puts "\n* Selection Menu. Enter correct digit or any other to quit *\n
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
    return puts "\tTry again, empty field" if st_title.empty?
    @created_stations << Station.new(st_title)
    puts "\tStation #{st_title} is created"
  end

  def train_operations
    puts "\n* Enter correct digit or any other to return *\n
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
    puts "\nEnter \"p\" to create passng train, \"c\" to create cargo one"
    puts "or any symbol to return"
    type_select = gets.chomp
    if type_select == 'p' || type_select == 'c'
      type_select == 'p' ? create_passng_train : create_cargo_train
    else
      puts "Exiting up..."
    end
  end

  def create_passng_train
    puts "\nEnter Train number:"
    train_num = gets.to_i
    return puts "\tTry again, empty field" if train_num.zero?
    @created_trains << PassengerTrain.new(train_num)
    puts "\tPassenger Train #{train_num} is created"
  end

  def create_cargo_train
    puts "\nEnter Train number:"
    train_num = gets.to_i
    return puts "\tTry again, empty field" if train_num.zero?
    @created_trains << CargoTrain.new(train_num)
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
      puts "\tFirstly create at least one Route and/or Train..."
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
      train_realloc.status_route
      puts "\nEnter \"f\" to go forward, \"r\" to reverse or any symbol to return"
      go_select = gets.chomp
      if go_select == 'f' || go_select == 'r'
        go_select == 'f' ? train_realloc.go_forward : train_realloc.go_back
        train_realloc.status_pos
      else
        puts "Exiting up..."
      end
    else
      puts "\tFirstly create at least one Route and/or Train..."
      self.menu
    end
  end

  def route_operations
    puts "\n* Enter correct digit or any other to return *\n
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
      puts "Enter First Station title in route:"
      st_first = gets.chomp.to_sym
      puts "Enter Last Station title in route:"
      st_last = gets.chomp.to_sym
      return puts "\tTry again, empty field(s)" if route_num.zero? || st_first.empty? || st_last.empty?
      add_first = stations.detect { |station| station.title == st_first }
      return puts "\tUnknown Station" if add_first.nil?
      add_last = stations.detect { |station| station.title == st_last }
      return puts "\tUnknown Station" if add_last.nil?
      @created_routes << Route.new(route_num, add_first, add_last)
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
    return puts "\tStation doesn't exist" if st_assign.nil?
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
    return puts "\tStation doesn't exist" if st_assign.nil?
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
    puts "\n* Enter correct digit or any other to return *\n
      1:  Create Carriage
      2:  Attach/Detach Carriage to Train"
    case gets.strip
      when "1"
        create_carriage
        self.carriage_operations
      when "2"
        attach_detach
        self.carriage_operations
      else
        puts "Exiting up..."
        self.menu
    end
  end

  def create_carriage
    puts "\nEnter \"p\" to create passng carriage, \"c\" to create cargo one"
    puts "Or any symbol to return"
    type_select = gets.chomp
    if type_select == 'p' || type_select == 'c'
      type_select == 'p' ? create_passng_carr : create_cargo_carr
    else
      puts "Exiting up..."
    end
  end

  def create_passng_carr
    puts "\nEnter Carriage number:"
    carr_num = gets.to_i
    return puts "\tTry again, empty field" if carr_num.zero?
    @created_carriages << PassengerCarriage.new(carr_num)
    puts "\tPassng Carriage #{carr_num} is created"
  end

  def create_cargo_carr
    puts "\nEnter Carriage number:"
    carr_num = gets.to_i
    return puts "\tTry again, empty field" if carr_num.zero?
    @created_carriages << CargoCarriage.new(carr_num)
    puts "\tCargo Carriage #{carr_num} is created"
  end

  def attach_detach
    puts "\nEnter Carriage number:"
    carr_num = gets.to_i
    return puts "\tTry again, empty field" if carr_num.zero?
    carr_relay = carriages.detect { |carr| carr.number == carr_num }
    return puts "\tUnknown Carriage" if carr_relay.nil?
    puts "\Enter Train number:"
    train_num = gets.to_i
    return puts "\tTry again, empty field" if train_num.zero?
    train_change = trains.detect { |train| train.number == train_num }
    return puts "\tUnknown Train" if train_change.nil?
    puts "\tThis train is of type #{train_change.type}"
    carr_relay.status
    puts "\nEnter \"a\" to Attach, \"d\" to Detach or any symbol to return"
    relay_select = gets.chomp
    if relay_select == 'a' || relay_select == 'd'
      relay_select == 'a' ?  train_change.carr_attach(carr_relay) : train_change.carr_detach(carr_relay)
      carr_relay.status
    else
      puts "Exiting up..."
    end
  end

  def info
    puts "\n* Enter correct digit or any other to return *\n
      1:  Stations Info
      2:  Trains Info
      3:  Routes Info
      4:  Carriage Info"
    case gets.strip
      when "1"
        puts "All of the stations, if any:"
        stations.each { |station| puts " #{station.title} #{station} " }
        puts "Enter Station title for Train list or Enter to quit:"
        st_title = gets.chomp.to_sym
        return puts "\tEmpty field, exiting..." if st_title.empty?
        st_info = stations.detect { |station| station.title == st_title }
        return puts "\tStation doesn't exist" if st_info.nil?
        puts "\tTrain(s), if present:"
        st_info.train_list.each { |train| puts " #{train.number} #{train}"}
        self.info
      when "2"
        puts "All of the trains, if any:"
        trains.each do |train|
          print " #{train.number},  #{train.type}. "
          print " Train is on route: #{train.route&.number}. "
          train.status_carr
          puts ""
        end
        self.info
      when "3"
        puts "All of the routes, if any:"
        routes.each { |route| puts " #{route.number}  #{route.station_list}" }
        self.info
      when "4"
        puts "\nEnter Carriage number:"
        carr_num = gets.to_i
        return puts "\tTry again, empty field" if carr_num.zero?
        carr_info = carriages.detect { |carr| carr.number == carr_num }
        return puts "\tUnknown Carriage" if carr_info.nil?
        carr_info.status
        self.info
      else
        puts "Exiting up..."
        self.menu
    end
  end

  def stations
    @created_stations
  end

  def trains
    @created_trains
  end

  def routes
    @created_routes
  end

  def carriages
    @created_carriages
  end
end
