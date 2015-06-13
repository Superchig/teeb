require_rel 'mob.rb'
require_rel '../interface/movement.rb'

# Has player-only specifics
# Unsure if it is even needed
class Player < Mob
  def move(next_room)
    Movement.show_room(self)
    super(next_room)
  end
end
