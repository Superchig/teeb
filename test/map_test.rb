require 'minitest/autorun'
require_relative '../lib/room.rb'
require_relative '../lib/mob.rb'
require_relative '../lib/map.rb'

class TestMap < Minitest::Test
  def setup
    # Initialize rooms, map, and mobs
    @custom_name = "Custom Mob 1"
    @custom_description = "Custom made! Bit of a wizard."

    @default_mob = Mob.new
    @custom_mob = Mob.new(@custom_name, @custom_description, 150, 150, 200, 200)
    @fighter = Mob.new("Fighting Joe", "Some sort of brawling type.", 250, 250, 100, 100)
    @map = Map.new
    @outside, @bar = Room.new, Room.new

    @outside.south = @bar
    @bar.north = @outside
  end

  def test_mobs_in_rooms
    @bar.add_mob(@fighter, @default_mob, @custom_mob)
    assert_equal 3, @bar.mobs.length

    assert @bar.mobs[0].eql? @fighter
    assert @bar.mobs[1].eql? @default_mob
    assert @bar.mobs[2].eql? @custom_mob
  end

  def test_move_mobs
    @bar.mobs.move(@fighter, north)

    assert_equal 2, @bar.mobs.length
    assert_equal 1, @outside.mobs.length
    assert @outside.mobs[0].eql? @fighter
  end
end
