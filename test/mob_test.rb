require 'minitest/autorun'
require 'require_all'
require_rel '../lib/mobs'
require_rel '../lib/map'

# Tests the stats and skills of mobs
# Placement and movement is in map_test.rb
class TestMob < Minitest::Test
  def setup
    @custom_name = "Custom Mob 1"
    @custom_description = "Custom made! Bit of a wizard."

    # Mobs setup
    @default_mob = Mob.new
    @custom_mob = Mob.new(@custom_name, @custom_description, 150, 150, 200, 200)

    # Items setup
    fork = Item.new("Odd Fork", <<-DESC
An unusually peculiar fork.
It has no abnormal traits, however.
DESC
)
    @default_mob.add_item(fork)
  end

  def test_name_and_description
    assert_equal @custom_name, @custom_mob.name
    assert_equal @custom_description, @custom_mob.description
  end

  def test_mob_health
    assert_equal 100, @default_mob.health
    assert_equal 150, @custom_mob.health

    assert_equal 100, @default_mob.max_health
    assert_equal 150, @custom_mob.max_health
  end

  def test_mob_magic_points
    assert_equal 100, @default_mob.magic_points
    assert_equal 200, @custom_mob.magic_points

    assert_equal 100, @default_mob.max_magic_points
    assert_equal 200, @custom_mob.max_magic_points
  end
end
