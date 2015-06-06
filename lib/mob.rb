class Mob
  attr_accessor :name, :description, :health, :max_health, :magic_points, :max_magic_points, :room

  # Basically, all room is is a tracker of what room the mob is in
  # Movement will be largely handled by the room method

  def initialize(name = "Default Mob Name", description = "This is the default mob description.", health = 100, \
                 max_health = 100, magic_points = 100, max_magic_points = 100, room = nil)
    @name = name
    @description = description
    @health = health
    @max_health = max_health
    @magic_points = magic_points
    @max_magic_points = max_magic_points
    @room = room
  end

  def attack(target)
    # stub
  end

  def to_s
    "Mob: #{@name}; health: #{@health}; magic: #{@magic_points}"
  end
end
