class Interface

  def initilaze 
  end

  def start
    loop do
      puts "###############################################"
   
      puts "Add - '1' if you want to create new station"  
  
      puts "add - '2' if you want to create new train" 
  
      puts "add - '3' if you want to create new route" 
  
      puts "add - '4' if you want to add station on route" 
  
      puts "add - '5' if you want to assign a route to a train" 
  
      puts "add - '6' if you  want add railway carriages to a train." 
  
      puts "add - '7' if you want unhitch the railway carriages from the train." 
  
      puts "add = '8' if you want move the train forward and backward along the route." 
  
      puts "add = '9' if you want view a list of stations and a list of trains in a station." 
  
      answer = gets.chomp.to_i
  
      case answer
        when 1 then create_new_station
        when 2 then create_new_train
        when 3 then create_new_routes
        when 4 then add_new_stations
        when 5 then route_assign
        when 6 then add_railway_wagon
        when 7 then remove_railway_wagon
        when 8 then move_train
        when 9 then show_list
      end
    end
  end

  private

  def create_new_station # создать новую станцию
    begin
      print "Enter station name: "
      name = gets.chomp
      Station.new(name)
    rescue => e
      puts e
      retry
    end
    puts "Station #{name.capitalize} has been created"
  end
  
  def create_new_train #создать новый поезд
    begin
      print "Enter number and type(passenger or cargo) of train"
      number = gets.chomp.to_i
      type = gets.chomp
      if type == 'cargo'
        Train.all << CargoTrain.new(number)
        puts "train with number - #{number} has been add like cargo train."
      elsif type == 'passenger'
        Train.all << PassengerTrain.new(number)
        puts "train with number - #{number} has been add like passenger train."
      else
        puts "wrong type"
      end
      rescue => e 
        puts e 
        retry
    end
  end
  
  def create_new_routes # создать новый маршрут
    puts " stations - #{stations.count} "
    Station.all.each_with_index do 
      |s, i| puts "#{i + 1}. #{s.show_name.capitalize}"
    end
    print "Chose number of the first station: "
    start = gets.chomp.to_i
    print "Chose number of the last station: "
    finish = gets.chomp.to_i
    Route.all << Route.new(stations[start - 1], stations[finish - 1])
    puts "Route from #{Station.all[start - 1].show_name.capitalize} to #{Station.all[finish - 1].show_name.capitalize} has been created!"
  end
  
  def add_new_stations # добавление станции в маршрут
    puts "stations what we have - #{Station.all.count}"
    Station.all.each_with_index do 
      |s, i| puts "#{i + 1}. #{s.show_name.capitalize}"
    end
    puts "And routes"
    Route.all.each_with_index do 
      |r, i| puts "#{i + 1}. Route from #{r.first.show_name.capitalize} to #{r.last.show_name.capitalize}"
    end
    puts "Choose station: "
    answer = gets.chomp.to_i
    puts "Choose route: "
    answer2 = gets.chomp.to_i
    Route.all[answer2 - 1].add_station(Station.all[answer - 1]) 
  end
  
  def route_assign # назначение маршрута поезду
    puts "trains - #{Train.all.count} and #{Train.all.count} routes."
    puts "Choose the train, to assign the route."
    Train.all.each_with_index do 
      |t, i| puts "#{i + 1}. #{t.type.to_s.capitalize} train, number #{t.number}"
    end
    answer1 = gets.chomp.to_i
    puts "Choose the route."
    Route.all.each_with_index do 
      |r, i| puts "#{i + 1}. Route from #{r.first.show_name.capitalize} to #{r.last.show_name.capitalize}"
    end
    answer2 = gets.chomp.to_i
    Train.all[answer1 - 1].take_route (Route.all[answer2 - 1])
    puts "Route from #{Route.all[answer2 - 1].first.show_name.capitalize} to #{Route.all[answer2 - 1].last.show_name.capitalize} has been assign for train number #{trains[answer1 - 1].number.to_s}"
  end

  def add_railway_wagon # добавление вагонов к поезду
    puts "Choose the train to add railway carriage."
    Train.all.each_with_index do 
      |t, i| puts "#{i + 1}. #{t.type.to_s.capitalize} train, number #{t.number}"
    end
    answer = gets.chomp.to_i
      if Train.all[answer - 1].type == :cargo
        Train.all[answer - 1].add_railway_wagon(CargoWagonRailway.new)
      elsif Train.all[answer - 1].type == :passenger
        Train.all[answer - 1].add_railway_wagon(RailwayWagonPassenger.new)
      end
    puts "Train number #{Train.all[answer - 1].number} now has #{Train.all[answer - 1].show_number_of_wagons} railway wagon."
  end
  
  def remove_railway_wagon # отцепка вагонов от поезда
    Train.all.each_with_index do 
      |t, i| puts "#{i + 1}. #{t.type.to_s.capitalize} train, number #{t.number} with #{t.show_number_of_wagons} railway wagon"
    end
    print "Choose the train to add railway carriage: "
    answer = gets.chomp.to_i
    Train.all[answer - 1].remove_railway_wagon(Train.all[answer - 1].number_of_wagons[0])
  end
  
  def move_train # перемещение поезда
    Train.all.each_with_index do 
      |t, i| puts "#{i + 1}. #{t.type.to_s.capitalize} train, number #{t.number}"
    end
    print "Choose the train to move: "
    answer = gets.chomp.to_i
    print "Press 1 to move forward or 2 to move backward:"
    dir = gets.chomp.to_i
    if dir == 1
      Train.all[answer + 1].move_forward
    elsif dir == 2
      Train.all[answer - 1].move_back
    end
  end
  
  def show_list # просмотр списка станций и список поездов
    puts 'Station List:'
    puts "\t!!EMPTY!!" if Station.all.empty?
    Station.all.each_with_index do 
      |s, i| puts "\t#{i + 1}. #{s.show_name.capitalize}."
    end
    puts ""
    puts 'Trains List:'
    puts "\t!!EMPTY!!" if trains.empty?
    Train.all.each_with_index do 
      |t, i| puts "\t#{i + 1}. #{t.type.to_s.capitalize} train, number #{t.number}, location - #{t.current_station.name.to_s}"
    end
  end
end
