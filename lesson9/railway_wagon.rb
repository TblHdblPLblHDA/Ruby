require_relative 'manufacturer'
require_relative 'instance_counter'

class RailwayWagon
  attr_reader :type
  def initialize(number_of_seats)
    @type = nil
    @number_of_seats = number_of_seats
  end
end
