require_relative './life'

class World

  def initialize(seed)
    @cells = {}

    seed.each do |coord|
      life = Life.new(*coord)
      @cells[get_location(life.x, life.y)] = life
    end
  end

  def lives
    @cells.values
  end

  def show_lives
    lives.map(&:name)
  end

  def tick
    lives.each do |life|
      evaluate(life)
    end
  end

  def evaluate(life)
    neighboring_coords = [
      [life.x - 1, life.y - 1],
      [life.x - 1, life.y],
      [life.x - 1, life.y + 1],

      [life.x,     life.y - 1],
      [life.x,     life.y + 1],

      [life.x + 1, life.y + 1],
      [life.x + 1, life.y],
      [life.x + 1, life.y - 1],
    ]
    
    dead_neighbors = []
    neighbors = neighboring_coords.reduce([]) { |neighbors, coords|
      if _life = @cells[get_location(*coords)]
        neighbors << _life
      else
        dead_neighbors << coords
      end

      neighbors
    }

    dead_neighbors.each { |dead_neighbor|
      if should_come_alive(dead_neighbor)
        life = Life.new(*coord)
        @cells[get_location(life.x, life.y)] = life
      end
    }

    if neighbors.count < 2 || neighbors.count > 3
      @cells.delete(get_location(life.x, life.y))
    end
  end

  def at(x, y)
    @cells[get_location(x, y)]
  end

  private

  def get_location(x, y)
    "#{x}:#{y}"
  end
end

# seed = [[0, 0]]
# world = World.new(seed)
# puts world.show_lives

# class AnyClass

#   def initialize
#     return "THING I WANT"
#   end

#   def my_method
#     return self
#   end
# end

# puts AnyClass.new.class
# puts AnyClass.new.my_method.class




# class MyHash

#   def initialize
#     @my_hash = {}
#   end

#   def [](key)
#     @my_hash[key]
#   end

#   def []=(key, value)
#     @my_hash[key] = value
#   end

#   def get_thing
#     @thing
#   end

#   def set_thing=(thing)
#     @thing = thing
#   end
# end
