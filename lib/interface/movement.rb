# require_rel '../map'
# require_rel '../mobs'

# Add a method of changing a string to a direction
class String
  def to_direction
    case self
    when 'north', 'n'
      :north
    when 'south', 's'
      :south
    when 'east', 's'
      :east
    when 'west', 'w'
      :west
    end
  end
end

# Manages and displays the map and choices
module Movement
  module_function

  def move_with_look(player, sym_direction)
    player.move(player.room.paths[sym_direction])
    player.room.show
  end

  def eval_move(direction, player)
    sym_direction = direction.to_direction
    should_move = !player.room.paths[sym_direction].nil?

    move_with_look(player, sym_direction) if should_move
    should_move
  end
end
