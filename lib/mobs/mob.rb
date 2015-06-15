require_rel "../mixins/lookable.rb"

# Everything that moves, though mostly npcs
# and the player
class Mob
  include Lookable

  attr_accessor :name, :description, :health, :max_health,
                :magic_points, :max_magic_points, :room
  attr_reader :items

  # Basically, room is a tracker of what room the mob is in
  # Movement will be largely handled by the room methods

  def initialize(name = "Default Mob Name",
                 description = "This is the default mob description.",
                 health = 100,
                 max_health = 100, magic_points = 100, max_magic_points = 100,
                 room = nil, items = [])
    @name = name
    @description = description
    @health = health
    @max_health = max_health
    @magic_points = magic_points
    @max_magic_points = max_magic_points
    @room = room
    @items = items
  end

  def attack(_target)
    # stub
  end

  def move(next_room)
    @room.remove_mob(self) unless room.nil?
    next_room.add_mob(self)
    @room = next_room
  end

  def add_item(*items_to_add)
    items_to_add.each { |item| @items.push(item) }
  end

  def remove_item(*items_to_remove)
    items_to_remove.each { |item| items_to_remove(item) }
  end

  def move_item(target_mob, *items_to_move)
    target_mob.add_item(*items_to_move)
    remove_item(*items_to_move)
  end

  def to_s
    "Mob: #{@name}; health: #{@health}; magic: #{@magic_points}"
  end
end
