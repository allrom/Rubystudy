# Lesson4 (Railway)  Rail Road Simulator Class
#
class RailRoadSim
  MAIN_MENU = "\n * Selection Menu. Enter correct menu digit or '0' to quit *"
  SUB_MENU  = "\n * Enter correct menu digit or '0' to return *"

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
      puts "
        1:  Create Station
        2:  Train Operations
        3:  Route Operations
        4:  Carriage Operations
        5:  Info"
      selector = gets.strip
      break if selector == "0"
      case selector
      when "1"
        create_station
      when "2"
        train_operations_menu
      when "3"
        route_operations_menu
      when "4"
        carriage_operations_menu
      when "5"
        info
      else
        puts "Incorrect input..."
      end
    end
    puts "Exiting..."
  end

  def create_station
    puts "\nEnter Station title:"
    st_title = gets.chomp.to_sym
    unless st_title.empty?
      if station_not_exists?(st_title)
        @stations << Station.new(st_title)
        puts "\tStation #{st_title} is created"
      else
        puts "\tStation is already here"
      end
    else
      puts "\tTry again, empty field"
    end
  end

  def train_operations_menu
    loop do
      puts SUB_MENU
      puts "
        1:  Create Train
        2:  Assign Route to Train
        3:  Relocate Train"
      selector = gets.strip
      break if selector == "0"
      case selector
      when "1"
        create_train_menu
      when "2"
        unless routes.empty? || trains.empty?
          assign_route_constr
        else
          puts "\tFirstly create at least one Route and/or Train"
        end
      when "3"
        unless routes.empty? || trains.empty?
          reallocate_train
        else
          puts "\tFirstly create at least one Route and/or Train"
        end
      else
        puts "Incorrect input..."
      end
    end
    puts "Exiting Up..."
  end

  def create_train_menu
    loop do
      puts SUB_MENU
      puts "
        1:  Create Passenger Train
        2:  Create Cargo Train"
      selector = gets.strip
      break if selector == "0"
      case selector
      when "1"
        create_passng_train
      when "2"
        create_cargo_train
      else
        puts "Incorrect input..."
      end
    end
    puts "Exiting Up..."
  end

  def create_passng_train
    puts "\nEnter Train number:"
    train_num = gets.to_i
    unless train_num.zero?
      if train_not_exists?(train_num, :passenger)
        @trains << PassengerTrain.new(train_num)
        puts "\tPassenger Train #{train_num} is created"
      else
        puts "\tTrain is already here"
      end
    else
      puts "\tTry again, empty field"
    end
  end

  def create_cargo_train
    puts "\nEnter Train number:"
    train_num = gets.to_i
    unless train_num.zero?
      if train_not_exists?(train_num, :cargo)
        @trains << CargoTrain.new(train_num)
        puts "\tCargo Train #{train_num} is created"
      else
        puts "\tTrain is already here"
      end
    else
      puts "\tTry again, empty field"
    end
  end

  def assign_route_constr
    @route_valid = @train_valid = nil
    loop do
      puts SUB_MENU
      puts "
        1:  Select Route
        2:  Select Train
        3:  Done with assign"
      selector = gets.strip
      break if selector == "0"
      case selector
      when "1"
        select_route
      when "2"
        select_train
      when "3"
        if @route_valid.nil? || @train_valid.nil?
          puts "...Nothing assigned, smth. not set"
        else
          assign_route(@train_valid, @route_valid)
        end
      else
        puts "Incorrect input..."
      end
    end
    puts "Exiting Up..."
  end

  def select_route
    puts "\nEnter Route number:"
    route_num = gets.to_i
    unless route_num.zero?
      if route_exists?(route_num)
        puts "\tRoute #{route_num} selected"
      else
        puts "\tRoute unknown"
      end
    else
      puts "\tTry again, empty field"
    end
  end

  def select_train
    puts "\nEnter Train number:"
    train_num = gets.to_i
    puts "\nEnter Train type (passenger or cargo):"
    train_type = gets.chomp.to_sym
    unless train_num.zero? || train_type.empty?
      if train_exists?(train_num, train_type)
        puts "\tTrain #{train_num} selected"
      else
        puts "\tTrain unknown"
      end
    else
      puts "\tTry again, empty field"
    end
  end

  def assign_route(train, route)
    unless route_yet_assigned?(train, route)
      train.route = route
      puts "\tRoute assigned"
    else
      puts "\tRoute is already assigned"
    end
  end

  def reallocate_train
    puts "\nEnter Train number:"
    train_num = gets.to_i
    puts "\nEnter Train type (passenger or cargo):"
    train_type = gets.chomp.to_sym
    unless train_num.zero?|| train_type.empty?
      if train_exists?(train_num, train_type)
        @train_valid.route.nil? ?
          puts("\tThis train has no routes") : reallocate_train_go_menu(@train_valid)
      else
        puts "\tUnknown Train"
      end
    else
      puts "\tTry again, empty field"
    end
  end

  def reallocate_train_go_menu(train)
    puts "\tThis train is on route #{train.route.number}"
    loop do
      puts SUB_MENU
      puts "
        1:  Train Go Forward
        2:  Train Go Reverse"
      selector = gets.strip
      break if selector == "0"
      case selector
      when "1"
        train.go_forward
        train_location(train)
      when "2"
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
      puts SUB_MENU
      puts "
        1:  Create Route
        2:  Station Operations"
      selector = gets.strip
      break if selector == "0"
      case selector
      when "1"
        unless stations.size < 2
          create_route_constr
        else
          puts "\tNeeds at least two stations to create route"
        end
      when "2"
        unless stations.empty?
          station_operations
        else
          puts "\tFirstly create at least one Station"
        end
      else
        puts "Incorrect input..."
      end
    end
    puts "Exiting Up..."
  end

  def create_route_constr
    @route_num = 0
    @start_st = @end_st = nil
    loop do
      puts SUB_MENU
      puts "
        1:  Enter Route Number
        2:  Select Start Station
        3:  Select End Station
        4:  Done with Route"
      selector = gets.strip
      break if selector == "0"
      case selector
      when "1"
        route_number_in
      when "2"
        start_station_in
      when "3"
        end_station_in
      when "4"
        if @route_num.zero? || @start_st.nil? || @end_st.nil?
          puts "...Nothing created, smth. not set"
        else
          create_route(@route_num, @start_st, @end_st)
        end
      else
        puts "Incorrect input..."
      end
    end
    puts "Exiting Up..."
  end

  def route_number_in
    puts "\nEnter Route number:"
    route_num = gets.to_i
    unless route_num.zero?
      if route_not_exists?(route_num)
        @route_num = route_num
        puts "\tRoute number #{route_num} is set"
      else
        puts "\tRoute is already here"
      end
    else
      puts "\tTry again, empty field"
    end
  end

  def start_station_in
    puts "\nStart Station title in the route:"
    st_title = gets.chomp.to_sym
    unless st_title.empty?
      if station_exists?(st_title)
        @start_st = @station_valid
        puts "\tStart Station #{st_title} is set"
      else
        puts "\tStation Unknown"
      end
    else
      puts "\tTry again, empty field"
    end
  end

  def end_station_in
    puts "\nEnd Station title in the route:"
    st_title = gets.chomp.to_sym
    unless st_title.empty?
      if station_exists?(st_title)
        @end_st = @station_valid
        puts "\tEnd Station #{st_title} is set"
      else
        puts "\tStation Unknown"
      end
    else
      puts "\tTry again, empty field"
    end
  end

  def create_route(number, start_station, end_station)
    if route_exists?(number)
      puts "\tRoute #{number} is already created"
    elsif
      start_station == end_station
      puts "\tBoundary stations same"
    else
      @routes << Route.new(number, start_station, end_station)
      puts "\tRoute #{number} is created"
    end
  end

  def station_operations
    @station_valid = @route_valid = nil
    loop do
      puts SUB_MENU
      puts "
        1:  Select Station
        2:  Select Route
        3:  Assign
        4:  Deassign"
      selector = gets.strip
      break if selector == "0"
      case selector
      when "1"
        select_station
      when "2"
        select_route
      when "3"
        if @route_valid.nil? || @station_valid.nil?
          puts "...Nothing assigned, smth. not set"
        else
          assign_station(@station_valid, @route_valid)
        end
      when "4"
        if @route_valid.nil? || @station_valid.nil?
          puts "...Nothing deassigned, smth. not set"
        else
          deassign_station(@station_valid, @route_valid)
        end
      else
        puts "Incorrect input..."
      end
    end
    puts "Exiting Up..."
  end

  def select_station
    puts "\nEnter Station title:"
    st_title = gets.chomp.to_sym
    unless st_title.empty?
      if station_exists?(st_title)
        puts "\tStation #{st_title} selected"
      else
        puts "\tStation Unknown"
      end
    else
      puts "\tTry again, empty field"
    end
  end

  def assign_station(station, route)
    unless station_yet_assigned?(route, station)
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
      !station.train_list.empty?
      puts "\tTrain(s) is stopped on this staton"
    else
      route.station_remove(station)
      puts "\tStation  is removed from Route"
    end
  end

  def carriage_operations_menu
    loop do
      puts SUB_MENU
      puts "
        1:  Create Carriage
        2:  Carriage Switch"
      selector = gets.strip
      break if selector == "0"
      case selector
      when "1"
        create_carriage_menu
      when "2"
        unless trains.empty? || carriages.empty?
          carriage_operations
        else
          puts "\tFirstly create at least one Train and/or Carriage"
        end
      else
        puts "Incorrect input..."
      end
    end
    puts "Exiting Up..."
  end

  def create_carriage_menu
    loop do
      puts SUB_MENU
      puts "
        1:  Create Passenger Carriage
        2:  Create Cargo Carriage"
      selector = gets.strip
      break if selector == "0"
      case selector
      when "1"
        create_passng_carr
      when "2"
        create_cargo_carr
      else
        puts "Incorrect input..."
      end
    end
    puts "Exiting Up..."
  end

  def create_passng_carr
    puts "\nEnter Carriage number:"
    carr_num = gets.to_i
    unless carr_num.zero?
      if carr_not_exists?(carr_num, :passenger)
        @carriages << PassengerCarriage.new(carr_num)
        puts "\tPassenger Carriage #{carr_num} is created"
      else
        puts "\tCarriage is already here"
      end
    else
      puts "\tTry again, empty field"
    end
  end

  def create_cargo_carr
    puts "\nEnter Carriage number:"
    carr_num = gets.to_i
    unless carr_num.zero?
      if carr_not_exists?(carr_num, :cargo)
        @carriages << CargoCarriage.new(carr_num)
        puts "\tCargo Carriage #{carr_num} is created"
      else
        puts "\tCarriage is already here"
      end
    else
      puts "\tTry again, empty field"
    end
  end

  def carriage_operations
    @carr_valid = @train_valid = nil
    loop do
      puts SUB_MENU
      puts "
        1:  Select Carriage
        2:  Select Train
        3:  Attach
        4:  Detach"
      selector = gets.strip
      break if selector == "0"
      case selector
      when "1"
        select_carriage_idx
      when "2"
        select_train_idx
      when "3"
        if @carr_valid.nil? || @train_valid.nil?
          puts "...Nothing attached, smth. not set"
        else
          attach_carriage(@carr_valid, @train_valid)
        end
      when "4"
        if @carr_valid.nil? || @train_valid.nil?
          puts "...Nothing detached, smth. not set"
        else
          detach_carriage(@carr_valid, @train_valid)
        end
      else
        puts "Incorrect input..."
      end
    end
    puts "Exiting Up..."
  end

  def select_carriage_idx
    carriage_list
    puts "\nEnter Carriage index number:"
    idx = gets.to_i
    unless idx.zero? || @carriages[idx - 1].nil?
      @carr_valid = @carriages[idx - 1]
      puts "\tCarriage #{@carr_valid.number} selected"
    else
      puts "\t...Nothing selected"
    end
  end

  def select_train_idx
    train_list
    puts "\nEnter Train index number:"
    idx = gets.to_i
    unless idx.zero? || @trains[idx - 1].nil?
      @train_valid = @trains[idx - 1]
      puts "\tTrain #{@train_valid.number} selected"
    else
      puts "\t...Nothing selected"
    end
  end

  def attach_carriage(carr, train)
    if !train.type_match?(carr)
      puts "\tCan't mix train/carriage types"
    elsif
      !carr.detached
      puts "\tThis carriage is attached already"
    elsif
      train.not_stopped?
      puts "\tNo action - train is in motion"
    else
      train.carr_attach(carr)
      puts "  #{carr.type.to_s} carriage #{carr.number} is attached to train #{carr.my_train_num}"
    end
  end

  def detach_carriage(carr, train)
    if carr.detached
      puts "\tThis carriage is detached already"
    elsif
      train.not_stopped?
      puts "\tNo action - train is in motion"
    elsif
      train.carriage_list.empty?
      puts "\tNo action - train has no carriages"
    else
      train.carr_detach(carr)
      puts "\t#{carr.type.to_s} carriage #{carr.number} is detached"
    end
  end

  def info
    loop do
      puts SUB_MENU
      puts "
        1:  Stations Info
        2:  Trains Info
        3:  Routes Info
        4:  Carriage Info"
      selector = gets.strip
      break if selector == "0"
      case selector
      when "1"
        station_list
      when "2"
        train_list
      when "3"
        route_list
      when "4"
        carriage_list
      else
        puts "Incorrect input..."
      end
    end
    puts "Exiting..."
  end

  def carriage_list
    puts "\nCarriages are (if any):"
    @carriages.each.with_index(1) do |carr, index|
      print " #{index}\.   #{carr.number}  #{carr.type}"
      print ",  status: ", carr.detached ? "detached\n" : "attached\n"
    end
  end

  def train_list
    puts "\nTrains are (if any):"
    @trains.each.with_index(1) do |train, index|
      print " #{index}\.   #{train.number}  #{train.type}, route #{train.route&.number}"
      print ".  Train has #{train.carriage_count} carriage(s): "
      train.carriage_list.each { |carr| print "#{carr.number} \> " }
      puts ''
    end
  end

  def station_list
    puts "\nAll of the stations, if any:"
    stations.each { |station| puts " #{station.title}   #{station} " }
    puts "\nEnter Station title for Train list or Enter to quit:"
    st_title = gets.chomp.to_sym
    unless st_title.empty?
      if station_exists?(st_title)
        puts "\tTrains, if any:"
        @station_valid.train_list.each do |train|
          puts "  #{train.number}    #{train.type}"
        end
      else
        puts "\tUnknown Station"
      end
    else
      puts "Exiting up..."
    end
  end

  def route_list
    puts "\nAll of the routes, if any:"
    routes.each do |route|
      print " #{route.number}, Stations: "
      route.station_list.each { |station| print " \* #{station.title}" }
    end
  end

  def station_exists?(st_title)
    !station_not_exists?(st_title)
  end

  def station_not_exists?(st_title)
    ( @station_valid = stations.detect { |station| station.title == st_title } ) == nil
  end

  def station_yet_assigned?(route, station)
    route.station_list.include?(station)
  end

  def route_exists?(route_num)
    !route_not_exists?(route_num)
  end

  def route_not_exists?(route_num)
    ( @route_valid = routes.detect { |route| route.number == route_num } ) == nil
  end

  def route_yet_assigned?(train, route)
    train.route&.number == route.number
  end

  def train_exists?(train_num, train_type)
    !train_not_exists?(train_num, train_type)
  end

  def train_not_exists?(train_num, train_type)
    ( @train_valid = train_finder(train_num, train_type) ) == nil
  end

  def train_finder(train_num, train_type)
    trains.detect do |train|
      train.number == train_num && train.type == train_type
    end
  end

  def train_location(train)
    puts "Train is at: #{train.actual_station&.title}"
    puts "The next is: #{train.next_station&.title}"
    puts "The previous is: #{train.previous_station&.title}"
  end

  def carr_exists?(carr_num, carr_type)
    !carr_not_exists?(carr_num, carr_type)
  end

  def carr_not_exists?(carr_num, carr_type)
    ( @carr_valid = carr_finder(carr_num, carr_type) ) == nil
  end

   def carr_finder(carr_num, carr_type)
    carriages.detect do |carr|
      carr.number == carr_num && carr.type == carr_type
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
