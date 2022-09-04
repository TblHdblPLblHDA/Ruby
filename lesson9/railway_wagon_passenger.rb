class RailwayWagonPassenger < RailwayWagon
  def initialize(places)
    super
    @places = places
    @occupied_places = 0
    @type = :passenger
  end

  def empty_volume
    @places
  end

  def filled_volume
    @occupied_places
  end

  def get_place
    @places -= 1
    @occupied_places += 1
  end

  def show_type
    @type
  end
end
