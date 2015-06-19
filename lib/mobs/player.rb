require_rel 'mob.rb'
require_rel '../interface/movement.rb'

# Has player-only specifics
class Player < Mob
  def check_for_lookable_name(lookable_name)
    room.mobs.each do |mob|
      lookable_name_exists = mob.name.downcase == lookable_name
      return mob if lookable_name_exists
    end

    room.items.each do |item|
      lookable_name_exists = item.name.downcase == lookable_name
      return item if lookable_name_exists
    end

    false
  end

  def eval_look(to_look)
    if to_look.empty?
      room.show
    else
      to_look.slice!(" ")
      look_at(to_look)
    end
  end

  def look_at(lookable_name)
    cannot_look_message = "You cannot see #{lookable_name}. Is it even here?"
    lookable = check_for_lookable_name(lookable_name)
    lookable ? (puts lookable.show) : (puts cannot_look_message)
  end
end
