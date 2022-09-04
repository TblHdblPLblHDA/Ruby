require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'railway_wagon'
require_relative 'railway_wagon_passenger'
require_relative 'railway_wagon_cargo'
require_relative 'interface'
require_relative 'manufacturer'
require_relative 'instance_counter'
require_relative 'validation'
require_relative 'acсessors'

interface = Interface.new
interface.start
