require_relative 'manufacturer'
require_relative 'instance_counter'

class RailwayWagon
  attr_reader :type
  def initialize
    @type = nil
  end
end
