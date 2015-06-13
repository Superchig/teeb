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

  def show_mobs(mobs)
    mobs.each do |mob|
      puts "There is a #{mob.name}"
    end
  end

  def show_room(room)
    puts room.description

    unseen_message = "You do not see anyone else here."

    room.mobs.nil? ? (puts unseen_message) : show_mobs(room.mobs)
  end

  def move_with_look(player, sym_direction)
    player.move(player.room.paths[sym_direction])
    show_room(player.room)
  end

  def eval_move(direction, player)
    show_room(player.room)

    sym_direction = direction.to_direction
    puts "\nsym_direction is #{sym_direction}\n"
    should_move = !player.room.paths[sym_direction].nil?

    should_move ? move_with_look(player, sym_direction) : (puts "You cannot move there.")
    should_move
  end
end
