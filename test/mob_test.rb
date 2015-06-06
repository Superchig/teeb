require 'minitest/autorun'
require_relative '../lib/mob.rb'

class TestMeme < Minitest::Test
  def setup
    @custom_name = "Custom Mob 1"
    @custom_description = "Custom made! Bit of a wizard."

    @default_mob = Mob.new
    @custom_mob = Mob.new(@custom_name, @custom_description, 150, 150, 200, 200)
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
