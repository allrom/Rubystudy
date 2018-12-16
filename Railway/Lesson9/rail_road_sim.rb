# Lesson8 (Railway)  Rail Road Simulator Class
#
class RailRoadSim
  attr_reader :stations, :trains, :routes, :carriages

  MAIN_MENU = <<-MENU.freeze
  \n * Selection Menu. Enter correct menu digit or '99' to quit *\n
    1:  Create Station
    2:  Train Operations
    3:  Route Operations
    4:  Carriage Operations
    5:  Info
  MENU
  SUB_MENU_HEADER = "\n * Enter correct menu digit or '99' to return *".freeze
  TRAIN_OPERATIONS_MENU = <<-MENU.freeze
    1:  Create Train
    2:  Assign Route to Train
    3:  Relocate Train
  MENU
  CREATE_TRAIN_MENU = <<-MENU.freeze
    1:  Create Passenger Train
    2:  Create Cargo Train
  MENU
  TRAIN_GO_MENU = <<-MENU.freeze
    1:  Train Go Forward
    2:  Train Go Reverse
  MENU
  ROUTE_OPERATIONS_MENU = <<-MENU.freeze
    1:  Create Route
    2:  Station Operations
  MENU
  STATION_OPERATIONS_MENU = <<-MENU.freeze
    1:  Assign Station
    2:  Deassign Station
  MENU
  CARRIAGE_OPERATIONS_MENU = <<-MENU.freeze
    1:  Create Carriage
    2:  Carriage Switch
    3:  Carriage Loading
  MENU
  CREATE_CARRIAGE_MENU = <<-MENU.freeze
    1:  Create Passenger Carriage
    2:  Create Cargo Carriage
  MENU
  SWITCH_CARRIAGE_MENU = <<-MENU.freeze
    1:  Attach Carriage
    2:  Detach Carriage
  MENU
  INFO_MENU = <<-MENU.freeze
    1:  Stations Info
    2:  Trains at Station Info
    3:  Trains Info
    4:  Routes Info
    5:  Carriage Info
  MENU
  MAIN_MENU_SELECT = {
    1 => :station_menu,
    2 => :train_operations_menu,
    3 => :route_operations_menu,
    4 => :carriage_operations_menu,
    5 => :info_menu
  }.freeze
  INFO_MENU_SELECT = {
    1 => :station_info,
    2 => :trains_at_station_info,
    3 => :train_info,
    4 => :route_info,
    5 => :carriage_info
  }.freeze

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

      item = MAIN_MENU_SELECT[selector]
      if item
        send(item)
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

  alias_method :station_menu, :create_station

  def select_carriage
    puts "\n Enter Carriage index number:"
    idx = gets.to_i
    if idx.zero? || @carriages[idx - 1].nil?
      return puts "\t...Nothing selected. Carriage is not set."
    end

    puts "\tCarriage #{@carriages[idx - 1].number} selected."
    @carriages[idx - 1]
  end

  def select_train
    train_list
    puts "\n Enter Train index number:"
    idx = gets.to_i
    if idx.zero? || @trains[idx - 1].nil?
      return puts "\t...Nothing selected. Train number is not set."
    end

    puts "\tTrain #{@trains[idx - 1].number} selected."
    @trains[idx - 1]
  end

  def select_station
    station_list
    puts "\n Enter Station index number:"
    idx = gets.to_i
    if idx.zero? || @stations[idx - 1].nil?
      return puts "\t...Nothing selected. Station is not set."
    end

    puts "\tStation #{@stations[idx - 1].title} selected."
    @stations[idx - 1]
  end

  def select_route
    route_list
    puts "\n Enter Route index number:"
    idx = gets.to_i
    if idx.zero? || @routes[idx - 1].nil?
      return puts "\t...Nothing selected. Route number is not set."
    end

    puts "\tRoute #{@routes[idx - 1].number} selected."
    @routes[idx - 1]
  end

  def train_operations_menu
    loop do
      puts SUB_MENU_HEADER, TRAIN_OPERATIONS_MENU
      selector = gets.to_i
      break if selector == 99

      case selector
      when 1 then create_train_menu
      when 2 then assign_route_menu
      when 3 then reallocate_train_menu
      else
        puts "Incorrect input..."
      end
    end
    puts "Exiting Up..."
  end

  def create_train_menu
    loop do
      puts SUB_MENU_HEADER, CREATE_TRAIN_MENU
      selector = gets.to_i
      break if selector == 99

      case selector
      when 1 then create_passenger_train
      when 2 then create_cargo_train
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
  rescue StandardError => e
    puts e.message + "\n\tTry again"
    retry if (attempt += 1) < 3
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
  rescue StandardError => e
    puts e.message + "\n\tTry again"
    retry if (attempt += 1) < 3
  end

  def assign_route_menu
    return puts "\tNo Routes or Trains" if [trains, routes].any?(&:empty?)
    return unless (route = select_route)
    return unless (train = select_train)

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

  def reallocate_train_menu
    return puts "\tNo Routes or Trains" if [trains, routes].any?(&:empty?)
    return unless (train = select_train)

    if train_has_no_routes?(train)
      puts "\tThis train has no routes"
    else
      puts "\tThis train is on route #{train.route.number}"
      train_location(train)
      reallocate_menu(train)
    end
  end

  def reallocate_menu(train)
    loop do
      puts SUB_MENU_HEADER, TRAIN_GO_MENU
      selector = gets.to_i
      break if selector == 99

      case selector
      when 1 then train.go_forward
      when 2 then train.go_back
      else
        puts "Incorrect input, location not changed..."
      end
      train_location(train)
    end
    puts "Exiting Up..."
  end

  def route_operations_menu
    loop do
      puts SUB_MENU_HEADER, ROUTE_OPERATIONS_MENU
      selector = gets.to_i
      break if selector == 99

      case selector
      when 1 then create_route_menu
      when 2 then station_operations_menu
      else
        puts "Incorrect input..."
      end
    end
    puts "Exiting Up..."
  end

  def create_route_menu
    return puts "\tAt least two stations needed" if stations.size < 2

    route_number = route_number_in
    return puts "\tRoute number is not set" if route_number.nil?

    puts "\n Select Start Station to place in route:"
    start_station = select_station
    return puts "\tStart Station is not set" if start_station.nil?

    puts "\n Select End Station to place in route:"
    end_station = select_station
    return puts "\tEnd Station is not set" if end_station.nil?

    create_route(route_number, start_station, end_station)
    puts "Exiting Up..."
  end

  def route_number_in
    puts "\n Enter route number:"
    route_num = gets.to_i
    return puts "\tTry again, empty field" if route_num.zero?

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
    return puts "\tCreate at least one Station first" if stations.empty?

    loop do
      puts SUB_MENU_HEADER, STATION_OPERATIONS_MENU
      selector = gets.to_i
      break if selector == 99

      case selector
      when 1 then assign_station
      when 2 then deassign_station
      else
        puts "Incorrect input..."
      end
    end
    puts "Exiting Up..."
  end

  def assign_station
    return unless (station = select_station)
    return unless (route = select_route)

    if !station_yet_assigned?(route, station)
      route.station_add(station)
      puts "\tStation assigned"
    else
      puts "\tStation is already assigned to this route"
    end
  end

  def deassign_station
    return unless (station = select_station)
    return unless (route = select_route)

    if !station_yet_assigned?(route, station)
      puts "\tStation is not in this Route"
    elsif route.boundary_station?(station)
      puts "\tStation is boundary"
    elsif station.train_stopped_here?
      puts "\tTrain(s) is stopped on this staton"
    else
      route.station_remove(station)
      puts "\tStation is removed from Route"
    end
  end

  def carriage_operations_menu
    loop do
      puts SUB_MENU_HEADER, CARRIAGE_OPERATIONS_MENU
      selector = gets.to_i
      break if selector == 99

      case selector
      when 1 then create_carriage_menu
      when 2 then switch_carriage_menu
      when 3 then carriage_volume_operations
      else
        puts "Incorrect input..."
      end
    end
    puts "Exiting Up..."
  end

  def create_carriage_menu
    loop do
      puts SUB_MENU_HEADER, CREATE_CARRIAGE_MENU
      selector = gets.to_i
      break if selector == 99

      case selector
      when 1 then create_passenger_carr
      when 2 then create_cargo_carr
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
    return puts "\tNo Trains or Carriages" if [trains, carriages].any?(&:empty?)

    carriage_list
    loop do
      puts SUB_MENU_HEADER, SWITCH_CARRIAGE_MENU
      selector = gets.to_i
      break if selector == 99

      case selector
      when 1 then attach_carriage
      when 2 then detach_carriage
      else
        puts "Incorrect input..."
      end
    end
    puts "Exiting Up..."
  end

  def ready_to_attach?(carriage, train)
    if !train.attachable_carriage?(carriage)
      puts "\tCan't mix train/carriage types"
    elsif carriage.attached?
      puts "\tThis carriage is attached already"
    elsif train.not_stopped?
      puts "\tNo action - train is in motion"
    else
      true
    end
  end

  def attach_carriage
    carriage_list_attach
    return unless (carriage = select_carriage)
    return unless (train = select_train)
    return unless ready_to_attach?(carriage, train)

    train.carr_attach(carriage)
    puts " #{carriage.type} carriage #{carriage.number}"\
    " is attached to train #{carriage.my_train_num}"
  end

  def ready_to_detach?(carriage, train)
    if carriage.detached?
      puts "\tThis carriage is detached already"
    elsif train.not_stopped?
      puts "\tNo action - train is in motion"
    elsif train.carriages.empty?
      puts "\tNo action - train has no carriages"
    elsif !train.carriages.include?(carriage)
      puts "\tNo action - wrong train/wrong carriage"
    else
      true
    end
  end

  def detach_carriage
    carriage_list_detach
    return unless (carriage = select_carriage)
    return unless (train = select_train)
    return unless ready_to_detach?(carriage, train)

    train.carr_detach!(carriage)
    puts "\t#{carriage.type} carriage #{carriage.number} is detached"
  end

  def carriage_volume_operations
    return puts "\tNo Carriages" if carriages.empty?

    carriage_list
    puts "\n Enter Carriage index number for Loading or Enter to pass:"
    idx = gets.to_i
    carr = @carriages[idx - 1]
    return puts "\t...Nothing selected" if idx.zero? || !carr
    return puts "\tFull Load, no free Seats/Capacity" if carr.volume_free.zero?

    carr.type == :passenger ? passenger_carr_load(carr) : cargo_carr_load(carr)
  end

  def passenger_carr_load(carriage)
    carriage.take_volume(1)
    print "\tOne Seat is occuped. Now Carriage #{carriage.number} has: "
    print "#{carriage.volume_free}/#{carriage.volume_used} free/ocp. Seats\n"
  end

  def cargo_carr_load(carriage)
    puts "\n Enter Capacity Units to be used up (number):"
    capacity = gets.to_i
    return puts("\tTry again, empty field") if capacity.zero?

    carriage.take_volume(capacity)
    print "\tNow Carriage #{carriage.number} has: "
    puts "#{carriage.volume_free}/#{carriage.volume_used} free/used Capacity"
  end

  def info_menu
    loop do
      puts SUB_MENU_HEADER, INFO_MENU
      selector = gets.to_i
      break if selector == 99

      item = INFO_MENU_SELECT[selector]
      if item
        send(item)
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
      print ". Free "
      if carr.type == :passenger
        print "seats: #{carr.volume_free}\n"
      else
        print "capacity: #{carr.volume_free}\n"
      end
    end
  end

  alias_method :carriage_info, :carriage_list

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
      puts " #{index}\. Number #{train.number}  #{train.type},"\
      "  route #{train.route&.number}"
    end
  end

  def carriages_in_train
    train_list
    puts "\n Enter Train index number to list carriages or Enter to pass:"
    idx = gets.to_i
    train = @trains[idx - 1]
    return puts "\t...Nothing selected" if idx.zero? || !train

    carriages_in_train_list(train)
  end

  def carriages_in_train_list(train)
    puts " Train has #{train.carriage_count} carriage(s): "
    train.carriages_avail do |carr|
      print "\tNumber #{carr.number}, #{carr.type}. "
      if carr.type == :passenger
        print "Seats free/occup. #{carr.volume_free}/#{carr.volume_used}\n"
      else
        print "Capacity free/used #{carr.volume_free}/#{carr.volume_used}\n"
      end
    end
  end

  alias_method :train_info, :carriages_in_train

  def station_list
    puts "\n All Stations are:"
    stations.each.with_index(1) do |station, index|
      puts "#{index}\.   #{station.title}   #{station} "
    end
  end

  alias_method :station_info, :station_list

  def all_stations
    puts "\n All Stations & Trains are:"
    stations.each.with_index(1) do |station, index|
      puts "#{index}\.   #{station.title}   #{station} "
      puts "\tTrains stopped here:"
      station.trains_avail do |train|
        puts " #{train.number}, #{train.type}, #{train.carriage_count} carrgs."
      end
    end
  end

  alias_method :trains_at_station_info, :all_stations

  def route_list
    puts "\n All Routes are:"
    routes.each.with_index(1) do |route, index|
      print "#{index}\.  Number #{route.number}, Stations: "
      route.station_list.each { |station| print " \* #{station.title}" }
      puts ""
    end
  end

  alias_method :route_info, :route_list

  def station_not_exists?(station_title)
    !stations.detect { |station| station.title == station_title }
  end

  def station_yet_assigned?(route, station)
    route.station_list.include?(station)
  end

  def route_not_exists?(route_num)
    !routes.detect { |route| route.number == route_num }
  end

  def route_yet_assigned?(train, route)
    train.route&.number == route.number
  end

  def train_not_exists?(train_num, train_type)
    !trains.detect { |trn| trn.number == train_num && trn.type == train_type }
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
    !carriages.detect { |crg| crg.number == carr_num && crg.type == carr_type }
  end
end
