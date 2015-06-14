require_rel 'mob.rb'
require_rel '../interface/movement.rb'

# Has player-only specifics
class Player < Mob
  def check_for_lookable(lookable_name)
    room.mobs.each do |mob|
      lookable_exists = mob.name.downcase == lookable_name
      lookable_exists ? (return mob) : (return false)
    end
  end

  def eval_look(to_look)
    if to_look.empty?
      room.show
    else
      to_look.slice!(" ")
      look_at(to_look)
    end
  end

  def look_at(lookable)
    cannot_look_message = "You cannot see #{lookable}. Is it even here?"
    (lookable = check_for_lookable(lookable)) ? (puts lookable.show) : (puts cannot_look_message)
  end
end
