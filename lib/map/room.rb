class Room
  attr_accessor :north, :south, :east, :west, :name, :description
  attr_reader :mobs

  def initialize(name = "Default Room", description = "This is the default room description", \
                 north = nil, south = nil, east = nil, west = nil, mobs = [])
    @name = name
    @description = description
    @north = north
    @south = south
    @east = east
    @west = west
    @mobs = mobs
  end

  def add_mob(*mobs)
    mobs_to_be_added = mobs
    mobs_to_be_added.each do |mob|
      @mobs.push(mob)
      mob.room = self
    end
  end

  def remove_mob(*mobs_for_deletion)
    mobs_to_be_deleted = mobs_for_deletion
    mobs_to_be_deleted.each do |mob|
      mob_index = @mobs.find_index(mob)

      mob_index.nil? ? (puts "Doh! Mob not found.") : (@mobs.delete_at(mob_index))
    end
  end
end
