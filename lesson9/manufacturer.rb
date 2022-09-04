module Manufacturer
  def manufacturer(name)
    @name = name
  end

  def show_manufacturer
    @name
  end

  private

  attr_accessor :name
end
