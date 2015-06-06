class Room
  attr_accessor :north, :south, :east, :west
  attr_reader :mobs

  def initialize(north=nil, south=nil, east=nil, west=nil, mobs=[])
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
    end
  end

  def remove_mob(*mobs)
    mobs_to_be_deleted = mobs
    mobs.each do |mob|
      mob_index = @mobs.find_index(mob)
      @mobs.delete_at(mob_index)
    end
  end
end
