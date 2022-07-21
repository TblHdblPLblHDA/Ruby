class CargoWagonRailway < RailwayWagon
  def initialize(volume)
    super
    @volume = volume
    @fillied_volume = 0
    @type = :cargo
  end

  def empty_volume
    @volume
  end

  def filled_volume
    @fillied_volume
  end

  def fill_volume(size)
    @volume -= size
    @filled_volume += size
  end
end
