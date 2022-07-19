require_relative 'manufacturer'
require_relative 'instance_counter'

class Station
  include Manufacturer
  include InstanceCounter
  attr_reader :name

  TITLE_FORMAT = /[a-z]/i
  @@all_station = []

  def self.all # метод класса (возвращает все станции)
    @@all_station
  end

  def initialize(name) #Имеет название, которое указывается при ее создании
    @name = name
    validate!
    @trains = []
    register_instances
  end

  def valid?
    validate!
  rescue
    false
  end

  def add_train(train) #Может принимать поезда (по одному за раз)
    return if @trains.include?(train)
    @trains << train # Пропустил букву s
  end

  def train_list #Может возвращать список всех поездов на станции, находящиеся в текущий момент
    @trains
  end

  def train_list_type(type) #Может возвращать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
    @trains.select do |train| #Стояла класс train, Хотя должен был быть trains. 
      train.type == type
    end
  end

  def delete_train(train) #Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции).
    @trains.delete(train)
  end

  def show_name
    @name
  end

  protected

  def validate!
    raise "Title format is not valid!" if name !~ TITLE_FORMAT
  end
end
