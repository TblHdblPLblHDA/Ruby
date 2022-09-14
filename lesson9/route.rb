require_relative 'manufacturer'
require_relative 'instance_counter'

class Route
  include Manufacturer
  include InstanceCounter
  extend Validation
  attr_reader :first, :last, :stations

  @all_route = []

  validate(:stations, :presence)

  def self.all 
    @all_route
  end

  def initialize(first, last)
    @first = first
    @last = last
    @stations = [first, last]
    register_instances
  end
  
  def add_station(station)
    @stations.insert(1, station)
  end
  
  def delete_station(station)
    @stations.delete(station)
  end
  
  def show_route
    @stations
  end
end
