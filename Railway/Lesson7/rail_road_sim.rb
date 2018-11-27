# Lesson6 (Railway)  Rail Road Simulator Class
#
class RailRoadSim
  attr_reader :stations, :trains, :routes, :carriages

  MAIN_MENU = <<-MENU
  \n * Selection Menu. Enter correct menu digit or '99' to quit *\n
    1:  Create Station
    2:  Train Operations
    3:  Route Operations
    4:  Carriage Operations
    5:  Info
  MENU
  SUB_MENU_HEADER = "\n * Enter correct menu digit or '99' to return *"
  TRAIN_OPERATIONS_MENU = <<-MENU
    1:  Create Train
    2:  Assign Route to Train
    3:  Relocate Train
  MENU
  CREATE_TRAIN_MENU = <<-MENU
    1:  Create Passenger Train
    2:  Create Cargo Train
  MENU
  TRAIN_GO_MENU = <<-MENU
    1:  Train Go Forward
    2:  Train Go Reverse
  MENU
  ROUTE_OPERATIONS_MENU = <<-MENU
    1:  Create Route
    2:  Station Operations
  MENU
  STATION_OPERATIONS_MENU = <<-MENU
    1:  Assign Station
    2:  Deassign Station
  MENU
  CARRIAGE_OPERATIONS_MENU = <<-MENU
    1:  Create Carriage
    2:  Carriage Switch
    3:  Carriage Loading
  MENU
  CREATE_CARRIAGE_MENU = <<-MENU
    1:  Create Passenger Carriage
    2:  Create Cargo Carriage
  MENU
  SWITCH_CARRIAGE_MENU = <<-MENU
    1:  Attach Carriage
    2:  Detach Carriage
  MENU
  INFO_MENU = <<-MENU
    1:  Stations Info
    2:  Stations & Trains Info
    3:  Trains Info
    4:  Routes Info
    5:  Carriage Info
  MENU

  def initialize
    puts "\n\t* RailRoad simulator *"
    @stations = []
    @trains = []
    @routes = []
    @carriages = []
  end

  def menu
    loop do
      puts MAIN_MENU
      selector = gets.to_i
      break if selector == 99
      case selector
      when 1
        create_station
      when 2
        train_operations_menu
      when 3
        route_operations_menu
      when 4
        carriage_operations_menu
      when 5
        info
      else
        puts "Incorrect input..."
      end
    end
    puts "Exiting..."
  end

  def create_station
    puts "\n Enter Station title:"
    station_title = gets.strip
    return puts("\tTry again, empty field") if station_title.empty?
    if station_not_exists?(station_title)
      @stations << Station.new(station_title)
      puts "\tStation #{station_title} is created"
    else
      puts "\tStation is already here"
    end
  end

  def select_carriage
    puts "\n Enter Carriage index number:"
    idx = gets.to_i
    if idx.zero? || @carriages[idx - 1].nil?
      puts "\t...Nothing selected"
      return
    end
    puts "\tCarriage #{@carriages[idx - 1].number} selected"
    @carriages[idx - 1]
  end

  def select_train
    train_list
    puts "\n Enter Train index number:"
    idx = gets.to_i
    if idx.zero? || @trains[idx - 1].nil?
      puts "\t...Nothing selected"
      return
    end
    puts "\tTrain #{@trains[idx - 1].number} selected"
    @trains[idx - 1]
  end

  def select_station
    station_list
    puts "\n Enter Station index number:"
    idx = gets.to_i
    if idx.zero? || @stations[idx - 1].nil?
      puts "\t...Nothing selected"
      return
    end
    puts "\tStation #{@stations[idx - 1].title} selected"
    @stations[idx - 1]
  end

  def select_route
    route_list
    puts "\n Enter Route index number:"
    idx = gets.to_i
    if idx.zero? || @routes[idx - 1].nil?
      puts "\t...Nothing selected"
      return
    end
    puts "\tRoute #{@routes[idx - 1].number} selected"
    @routes[idx - 1]
  end

  def train_operations_menu
    loop do
      puts SUB_MENU_HEADER
      puts TRAIN_OPERATIONS_MENU
      selector = gets.to_i
      break if selector == 99
      case selector
      when 1
        create_train_menu
      when 2
        if routes.empty? || trains.empty?
          puts "\tFirstly create at least one Route and/or Train"
          return
        end
        assign_route_menu
      when 3
        if routes.empty? || trains.empty?
          puts "\tFirstly create at least one Route and/or Train"
          return
        end
        reallocate_train
      else
        puts "Incorrect input..."
      end
    end
    puts "Exiting Up..."
  end

  def create_train_menu
    loop do
      puts SUB_MENU_HEADER
      puts CREATE_TRAIN_MENU
      selector = gets.to_i
      break if selector == 99
      case selector
      when 1
        create_passenger_train
      when 2
        create_cargo_train
      else
        puts "Incorrect input..."
      end
    end
    puts "Exiting Up..."
  end

  def create_passenger_train
    puts "\n Enter Train number (3 letters|digits(-optional)2 letters|digits):"
    train_num = gets.strip
    attempt ||= 0
    if train_not_exists?(train_num, :passenger)
      @trains << PassengerTrain.new(train_num)
      puts "\tPassenger Train #{train_num} is created"
    else
      puts "\tTrain is already here"
    end
  rescue => e
    puts e.message + "\n\tTry again"
    retry if ( attempt += 1 ) < 3
  end

  def create_cargo_train
    puts "\n Enter Train number (3 letters|digits(-optional)2 letters|digits):"
    train_num = gets.strip
    attempt ||= 0
    if train_not_exists?(train_num, :passenger)
      @trains << CargoTrain.new(train_num)
      puts "\tCargo Train #{train_num} is created"
    else
      puts "\tTrain is already here"
    end
  rescue => e
    puts e.message + "\n\tTry again"
    retry if ( attempt += 1 ) < 3
  end

  def assign_route_menu
    route = select_route
    return puts ("\tRoute number is not set") if route.nil?
    train = select_train
    return puts ("\tTrain number is not set") if train.nil?
    assign_route(train, route)
    puts "Exiting Up..."
  end

  def assign_route(train, route)
    if !route_yet_assigned?(train, route)
      train.route = route
      puts "\tRoute assigned"
    else
      puts "\tRoute is already assigned"
    end
  end

  def reallocate_train
    train = select_train
    if train_has_no_routes?(train)
      puts"\tThis train has no routes"
    else
      reallocate_train_go_menu(train)
    end
  end

  def reallocate_train_go_menu(train)
    puts "\tThis train is on route #{train.route.number}"
    loop do
      puts SUB_MENU_HEADER
      puts TRAIN_GO_MENU
      selector = gets.to_i
      break if selector == 99
      case selector
      when 1
        train.go_forward
        train_location(train)
      when 2
        train.go_back
        train_location(train)
      else
        puts "Incorrect input..."
      end
    end
    puts "Exiting Up..."
  end

  def route_operations_menu
    loop do
      puts SUB_MENU_HEADER
      puts ROUTE_OPERATIONS_MENU
      selector = gets.to_i
      break if selector == 99
      case selector
      when 1
        if stations.size < 2
          puts "\tNeeds at least two stations to create route"
          return
        end
        create_route_menu
      when 2
        if stations.empty?
          puts "\tFirstly create at least one Station"
          return
        end
        station_operations_menu
      else
        puts "Incorrect input..."
      end
    end
    puts "Exiting Up..."
  end

  def create_route_menu
    route_number = route_number_in
    return puts ("\tRoute number is not set") if route_number.nil?
    puts "\n Select Start Station to place in route:"
    start_station = select_station
    return puts ("\tStart Station is not set") if start_station.nil?
    puts "\n Select End Station to place in route:"
    end_station = select_station
    return puts ("\tEnd Station is not set") if end_station.nil?
    create_route(route_number, start_station, end_station)
    puts "Exiting Up..."
  end

  def route_number_in
    puts "\n Enter route number:"
    route_num = gets.to_i
    return puts("\tTry again, empty field") if route_num.zero?
    if route_not_exists?(route_num)
      puts "\tRoute number #{route_num} is set"
      route_num
    else
      puts "\tRoute is already here"
    end
  end

  def create_route(number, start_station, end_station)
    if start_station == end_station
      puts "\tBoundary stations are same"
    else
      @routes << Route.new(number, start_station, end_station)
      puts "\tRoute #{number} is created"
    end
  end

  def station_operations_menu
    loop do
      puts SUB_MENU_HEADER
      puts STATION_OPERATIONS_MENU
      selector = gets.to_i
      break if selector == 99
      case selector
      when 1
        station = select_station
        return puts ("\tStation is not set") if station.nil?
        route = select_route
        return puts ("\tRoute is not set") if route.nil?
        assign_station(station, route)
      when 2
        station = select_station
        return puts ("\tStation is not set") if station.nil?
        route = select_route
        return puts ("\tRoute is not set") if route.nil?
        deassign_station(station, route)
      else
        puts "Incorrect input..."
      end
    end
    puts "Exiting Up..."
  end

  def assign_station(station, route)
    if !station_yet_assigned?(route, station)
      route.station_add(station)
      puts "\tStation assigned"
    else
      puts "\tStation is already assigned to this route"
    end
  end

  def deassign_station(station, route)
    if !station_yet_assigned?(route, station)
      puts "\tStation is not in this Route"
    elsif
      route.boundary_station?(station)
      puts "\tStation is boundary"
    elsif
      station.train_stopped_here?
      puts "\tTrain(s) is stopped on this staton"
    else
      route.station_remove(station)
      puts "\tStation is removed from Route"
    end
  end

  def carriage_operations_menu
    loop do
      puts SUB_MENU_HEADER
      puts CARRIAGE_OPERATIONS_MENU
      selector = gets.to_i
      break if selector == 99
      case selector
      when 1
        create_carriage_menu
      when 2
        if trains.empty? || carriages.empty?
          puts "\tFirstly create at least one Train and/or Carriage"
          return
        end
        switch_carriage_menu
      when 3
        return puts "\tFirstly create at least one Carriage" if carriages.empty?
        carriage_volume_operations
      else
        puts "Incorrect input..."
      end
    end
    puts "Exiting Up..."
  end

  def create_carriage_menu
    loop do
      puts SUB_MENU_HEADER
      puts CREATE_CARRIAGE_MENU
      selector = gets.to_i
      break if selector == 99
      case selector
      when 1
        create_passenger_carr
      when 2
        create_cargo_carr
      else
        puts "Incorrect input..."
      end
    end
    puts "Exiting Up..."
  end

  def create_passenger_carr
    puts "\nEnter Carriage number:"
    carr_num = gets.to_i
    return puts("\tTry again, empty field") if carr_num.zero?
    if carr_not_exists?(carr_num, :passenger)
      puts "\nEnter Seats total number:"
      carr_seats = gets.to_i
      return puts("\tTry again, empty field") if carr_seats.zero?
      @carriages << PassengerCarriage.new(carr_num, carr_seats)
      puts "\tPassenger Carriage #{carr_num} is created"
    else
      puts "\tCarriage is already here"
    end
  end

  def create_cargo_carr
    puts "\nEnter Carriage number:"
    carr_num = gets.to_i
    return puts("\tTry again, empty field") if carr_num.zero?
    if carr_not_exists?(carr_num, :cargo)
      puts "\nEnter Capacity total number:"
      carr_cap = gets.to_i
      return puts("\tTry again, empty field") if carr_cap.zero?
      @carriages << CargoCarriage.new(carr_num, carr_cap)
      puts "\tCargo Carriage #{carr_num} is created"
    else
      puts "\tCarriage is already here"
    end
  end

  def switch_carriage_menu
    loop do
      puts SUB_MENU_HEADER
      puts SWITCH_CARRIAGE_MENU
      selector = gets.to_i
      break if selector == 99
      case selector
      when 1
        carriage_list
        puts "\n\tAttachable, of them:"
        carriage_list_attach
        carriage = select_carriage
        return puts ("\tCarriage is not set") if carriage.nil?
        train = select_train
        return puts ("\tTrain is not set") if train.nil?
        attach_carriage(carriage, train)
      when 2
        carriage_list
        puts "\n\tDetachable, of them:"
        carriage_list_detach
        carriage = select_carriage
        return puts ("\tCarriage is not set") if carriage.nil?
        train = select_train
        return puts ("\tTrain is not set") if train.nil?
        detach_carriage(carriage, train)
      else
        puts "Incorrect input..."
      end
    end
    puts "Exiting Up..."
  end

  def attach_carriage(carr, train)
    if !train.attachable_carriage?(carr)
      puts "\tCan't mix train/carriage types"
    elsif
      carr.attached?
      puts "\tThis carriage is attached already"
    elsif
      train.not_stopped?
      puts "\tNo action - train is in motion"
    else
      train.carr_attach(carr)
      puts " #{carr.type.to_s} carriage #{carr.number} is attached to train #{carr.my_train_num}"
    end
  end

  def detach_carriage(carr, train)
    if carr.detached?
      puts "\tThis carriage is detached already"
    elsif
      train.not_stopped?
      puts "\tNo action - train is in motion"
    elsif
      train.carriages.empty?
      puts "\tNo action - train has no carriages"
    elsif
      !train.carriages.include?(carr)
      puts "\tNo action - wrong train/wrong carriage"
    else
      train.carr_detach!(carr)
      puts "\t#{carr.type.to_s} carriage #{carr.number} is detached"
    end
  end

  def carriage_volume_operations
    carriage_list
    puts "\n Enter Carriage index number for Loading or Enter to pass:"
    puts "\n (One Seat will be occipied if Carriage is of type \"Passenger\","
    puts " Entered Capacity Units will be used up if Carriage is of type \"Cargo\")"
    idx = gets.to_i
    carriage = @carriages[idx - 1]
    if idx.zero? || !carriage
      puts "\t...Nothing selected"
      return
    end
    if carriage.type == :passenger
      return puts "\tFull Load, no more free Seats" if carriage.seats_free.zero?
      carriage.occupy_seat
      print "\tNow Carriage #{carriage.number} has: "
      print "#{carriage.seats_free}/#{carriage.seats_occupied} free/occup. Seats\n"
    else
      return puts "\tFull Load, no more free Capacity" if carriage.capacity_free.zero?
      puts "\nEnter Capacity to be used up (number):"
      capacity = gets.to_i
      return puts("\tTry again, empty field") if capacity.zero?
      carriage.use_capacity(capacity)
      print "\tNow Carriage #{carriage.number} has: "
      print "#{carriage.capacity_free}/#{carriage.capacity_used} free/used Capacity\n"
    end
  end

  def info
    loop do
      puts SUB_MENU_HEADER
      puts INFO_MENU
      selector = gets.to_i
      break if selector == 99
      case selector
      when 1
        station_list
      when 2
        all_trains_stations
      when 3
        carriages_in_train
      when 4
        route_list
      when 5
        carriage_list
      else
        puts "Incorrect input..."
      end
    end
    puts "Exiting..."
  end

  def carriage_list
    puts "\n All Carriages are:"
    carriages.each.with_index(1) do |carr, index|
      print " #{index}\.  Number #{carr.number},  #{carr.type}"
      print ", status: ", carr.detached? ? "detached" : "attached"
      print ". Free ", carr.type == :passenger ? "seats: #{carr.seats_free}\n" : "capacity: #{carr.capacity_free}\n"
    end
  end

  def carriage_list_attach
    puts "\n Detached Carriages are:"
    carriages.select.with_index(1) do |carr, index|
      if carr.detached?
        print " #{index}\.  Number #{carr.number}  #{carr.type}"
        print ",  status:  detached\n"
      end
    end
  end

  def carriage_list_detach
    puts "\n Attached Carriages are:"
    carriages.select.with_index(1) do |carr, index|
      if carr.attached?
        print " #{index}\.  Number #{carr.number}  #{carr.type}"
        print ",  status:  attached\n"
      end
    end
  end

  def train_list
    puts "\n All Trains are:"
    trains.each.with_index(1) do |train, index|
      puts " #{index}\. Number #{train.number}  #{train.type}, route #{train.route&.number}"
    end
  end

  def carriages_in_train
    train_list
    puts "\n Enter Train index number to list carriages or Enter to pass:"
    idx = gets.to_i
    train = @trains[idx - 1]
    if idx.zero? || !train
      puts "\t...Nothing selected"
      return
    end
    puts " Train has #{train.carriage_count} carriage(s): "
    train.carriages_avail do |carrg|
      print "\tNumber #{carrg.number}, #{carrg.type}. "
      if carrg.type == :passenger
        print "Seats free/occup. #{carrg.seats_free}/#{carrg.seats_occupied}\n"
      else
        print "Capacity free/used #{carrg.capacity_free}/#{carrg.capacity_used}\n"
      end
    end
  end

  def station_list
    puts "\n All Stations are:"
    stations.each.with_index(1) do |station, index|
      puts "#{index}\.   #{station.title}   #{station} "
    end
  end

  def all_trains_stations
    puts "\n All Stations & Trains are:"
    stations.each.with_index(1) do |station, index|
      puts "#{index}\.   #{station.title}   #{station} "
      puts "Trains stopped here:"
      station.trains_avail { |train| puts " #{train.number}, #{train.type}, #{train.carriage_count} carrgs." }
    end
  end

  def route_list
    puts "\n All Routes are:"
    routes.each.with_index(1) do |route, index|
      print "#{index}\.  Number #{route.number}, Stations: "
      route.station_list.each { |station| print " \* #{station.title}" }
      puts ''
    end
  end

  def station_not_exists?(station_title)
    stations.detect { |station| station.title == station_title } == nil
  end

  def station_yet_assigned?(route, station)
    route.station_list.include?(station)
  end

  def route_not_exists?(route_num)
    routes.detect { |route| route.number == route_num } == nil
  end

  def route_yet_assigned?(train, route)
    train.route&.number == route.number
  end

  def train_not_exists?(train_num, train_type)
    trains.detect { |train| train.number == train_num && train.type == train_type } == nil
  end

  def train_has_no_routes?(train)
    train.route.nil?
  end

  def train_location(train)
    puts "Train is at: #{train.actual_station&.title}"
    puts "The next is: #{train.next_station&.title}"
    puts "The previous is: #{train.previous_station&.title}"
  end

  def carr_not_exists?(carr_num, carr_type)
    carriages.detect { |carr| carr.number == carr_num && carr.type == carr_type } == nil
  end
end
