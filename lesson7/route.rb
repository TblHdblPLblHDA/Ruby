require_relative 'manufacturer'
require_relative 'instance_counter'

class Route
  include Manufacturer
  include InstanceCounter
  attr_reader :first, :last, :stations

  @@all_route = []

  def self.all # метод класса (возвращает все пути)
    @@all_route
  end

  def initialize(first, last) # Имеет начальную и конечную станцию. Начальная и конечная станции указываются при создании маршрута.
    @first = first
    @last = last
    @stations = [first, last]
    register_instances
  end
  
  def add_station(station) # Промежуточные станции могут добавляться между начальной и конечной.
    @stations.insert(1, station)
  end
  
  def delete_station(station) # Может удалять промежуточную станцию из списка
    @stations.delete(station)
  end
  
  def show_route # Может выводить список всех станций
    @stations
  end
end
