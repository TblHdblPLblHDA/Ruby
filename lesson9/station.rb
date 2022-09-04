require_relative 'manufacturer'
require_relative 'instance_counter'
require_relative 'validation'

class Station
  include Manufacturer
  include InstanceCounter
  include Validation

  attr_reader :name

  TITLE_FORMAT = /[a-z]/i.freeze
  @all_station = []

  validate(:name, :presence)
  validate(:name, :type, String)
  validate(:name, :format, TITLE_FORMAT)

  def self.all
    @all_station
  end

  def initialize(name)
    @name = name
    validate!
    @trains = []
    register_instances
  end

  def add_train(train)
    return if @trains.include?(train)
    @trains << train
  end

  def train_list
    @trains
  end

  def train_list_type(type)
    @trains.select do |train|
      train.type == type
    end
  end

  def delete_train(train)
    @trains.delete(train)
  end

  def show_name
    @name
  end

  def trains_to_block(&block)
    @trains.each { |train| block.call(train) }
  end

end
