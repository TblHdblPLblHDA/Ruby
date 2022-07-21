require_relative 'manufacturer'
require_relative 'instance_counter'

class Train
  include Manufacturer
  include InstanceCounter
  attr_reader :number, :type, :number_of_wagons
  
  NUMBER_FORMAT = /^[a-z|\d]{3}-*[a-z|\d]{2}$/i
  @@all_trains = []

  def self.all #метод класса (возвращает все поезда)
    @@all_trains
  end
  
  def self.find(number)
    @@all_trains.detect { |train| train.number == number}
  end

  def initialize(number) # Имеет номер, тип, количество вагонов (указывается при создани)
    @speed = 0
    @number = number
    @type = nil
    @number_of_wagons = []
    validate!
    register_instances
  end 
  
  def valid?
    validate!
  rescue
    false
  end
 
  def speed # Может набирать скорость
    @speed += 5
  end

  def current_speed  # Может возвращать текущую скорость
    @speed
  end

  def stop # Может тормозить (сбрасывать скорость до нуля)
    @speed = 0
  end

  def take_route(route) # Может принимать маршрут следования
    @route_for_train = route
    @pozition_on_route = 0
    @route_for_train.station[pozition_on_route].add_train(self)
  end

  def add_railway_wagon(railway_wagon)
    return false unless railway_wagon.type == @type
    if @speed == 0 
      @number_of_wagons << railway_wagon
    end
  end

  def remove_railway_wagon(railway_wagon)
    if @speed == 0
      @number_of_wagons.delete(railway_wagon)
    end
  end

  def move_forward # Может перемещаться вперёд
    @route_for_train.station[@pozition_on_route].remove_train(self)
    @pozition_on_route += 1
    @route_for_train.station[@pozition_on_route].add_train(self)
  end

  def move_back # Может перемещаться назад
    @route_for_train.station[@pozition_on_route].remove_train(self)
    @pozition_on_route -= 1
    @route_for_train.station[@pozition_on_route].add_train(self)
  end

  def show_number_of_wagons
    @number_of_wagons.length
  end

  def show_stations # Возвращать предыдущую станцию, текущую, следующую, на основе маршрута
    [
    @route_for_train.station[@pozition_on_route - 1],
    @route_for_train.station[@pozition_on_route],
    @route_for_train.station[@pozition_on_route + 1]
    ]
  end

  def railway_wagon_to_block(&block)
    @railway_wagon.each_with_index{ |rc, i| block.call(rc, i) }
  end

  protected
  def validate!
    raise "Number format is not valid!" if number !~ NUMBER_FORMAT
  end
end
