require_rel "../mixins/"

# Everything that moves, though mostly npcs
# and the player
class Mob
  include Lookable
  include Inventory
  include InventoryEquipment

  attr_accessor :name, :description, :health, :max_health,
                :magic_points, :max_magic_points, :room

  # Basically, room is a tracker of what room the mob is in.

  def initialize(name = "Default Mob Name",
                 description = "This is the default mob description.",
                 health = 100,
                 max_health = 100, magic_points = 100, max_magic_points = 100,
                 room = nil, items = [], equipment = {})
    @name = name
    @description = description
    @health = health
    @max_health = max_health
    @magic_points = magic_points
    @max_magic_points = max_magic_points
    @room = room
    init_items(items)
    @equipment = equipment
  end

  def attack(_target)
    # stub
  end

  def move(next_room)
    @room.remove_mob(self) unless room.nil?
    next_room.add_mob(self)
    @room = next_room
  end

  def to_s
    "Mob: #{@name}; health: #{@health}; magic: #{@magic_points}"
  end
end
