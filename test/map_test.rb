require 'minitest/autorun'
require 'require_all'
require_rel '../lib/mobs'
require_rel '../lib/map'

class TestMap < Minitest::Test
  def setup
    # Initialize rooms, map, and mobs
    @custom_name = "Custom Mob 1"
    @custom_description = "Custom made! Bit of a wizard."

    @default_mob = Mob.new
    @custom_mob = Mob.new(@custom_name, @custom_description, 150, 150, 200, 200)
    @fighter = Mob.new("Fighting Joe", "Some sort of brawling type.", 250, 250, 100, 100)
    @outside, @bar = Room.new, Room.new

    @outside.south = @bar
    @bar.north = @outside
    @bar.add_mob(@fighter, @default_mob, @custom_mob)
  end

  def test_mobs_in_rooms
    assert_equal 3, @bar.mobs.length

    assert @bar.mobs[0].eql? @fighter
    assert @bar.mobs[1].eql? @default_mob
    assert @bar.mobs[2].eql? @custom_mob

    assert_equal @bar, @fighter.room
    assert_equal @bar, @default_mob.room
    assert_equal @bar, @custom_mob.room
  end

  def test_remove_mobs
    @bar.remove_mob(@fighter)

    assert_equal 2, @bar.mobs.length
  end

  def test_move_mobs
    @fighter.move(@outside)

    assert_equal 2, @bar.mobs.length
    assert_equal 1, @outside.mobs.length
    assert @outside.mobs[0].eql? @fighter
  end
end
