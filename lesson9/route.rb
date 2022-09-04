require_relative 'manufacturer'
require_relative 'instance_counter'

class Route
  include Manufacturer
  include InstanceCounter
  extend Validation
  attr_reader :first, :last, :stations

  @all_route = []

  # метод класса (возвращает все пути)
  def self.all 
    @all_route
  end

  # Имеет начальную и конечную станцию. Начальная и конечная станции указываются при создании маршрута.
  def initialize(first, last)
    @first = first
    @last = last
    @stations = [first, last]
    register_instances
  end
  
  # Промежуточные станции могут добавляться между начальной и конечной.
  def add_station(station)
    @stations.insert(1, station)
  end
  
  # Может удалять промежуточную станцию из списка
  def delete_station(station)
    @stations.delete(station)
  end
  
  # Может выводить список всех станций
  def show_route
    @stations
  end
end
