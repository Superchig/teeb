class Mob
  attr_accessor :name, :description, :health, :max_health, :magic_points, :max_magic_points

  def initialize(name="Default Mob Name", description="This is the default mob description.", health=100, \
                 max_health=100, magic_points=100, max_magic_points=100)
    @name = name
    @description = description
    @health = health
    @max_health = max_health
    @magic_points = magic_points
    @max_magic_points = max_magic_points
  end

  def attack(target)
    # stub
  end

  def to_s
    "#{name}"
  end
end
