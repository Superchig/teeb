require_rel '../map'
require_rel '../mobs'

# Add a method of changing a string to a direction
class String
  def to_direction
    is_north = self.downcase == "north"
    is_south = self.downcase == "south"
    is_east = self.downcase == "east"
    is_west = self.downcase == "west"

    nil unless is_north || is_south || is_east || is_west

    self.to_sym
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

  def eval_move(mob, direction)
    sym_direction = direction.to_sym
    should_move = !mob.room[sym_direction].nil?

    should_move ? mob.move(mob.room.paths[sym_direction]) : (puts "You cannot move there.")
  end
end
