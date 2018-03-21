require 'faker'

class Life

  attr_reader :x, :y, :name

  def initialize(x, y)
    @x = x
    @y = y
    @name = Faker::StarWars.planet
  end
  
end