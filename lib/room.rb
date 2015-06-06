class Room
  attr_accessor :north, :south, :east, :west, :mobs

  def initialize(north=nil, south=nil, east=nil, west=nil, mobs=nil)
    @north = north
    @south = south
    @east = east
    @west = west
    @mobs = []
    init_mobs(mobs)
  end

  def init_mobs(*input_mobs)
    input_mobs.each { |mob| @mobs.push(mob) }
  end
end
