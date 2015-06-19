require 'minitest/autorun'
require 'require_all'

require_rel '../lib/items'
require_rel '../lib/map'
require_rel '../lib/mobs'

# Tests out ownership, transfering, and removal of items
class TestMap < Minitest::Test
  def setup
    @custom_name = "Custom Mob 1"
    @custom_description = "Custom made! Bit of a wizard."

    # Mobs setup
    @default_mob = Mob.new
    @custom_mob = Mob.new(@custom_name, @custom_description, 150, 150, 200, 200)

    # Items setup
    @fork = Item.new("Odd Fork", <<-DESC
An unusually peculiar fork.
It has no abnormal traits, however.
DESC
                    )
    @default_mob.add_item(@fork)
  end

  def test_ownership
    assert_equal 1, @default_mob.items.length
    assert @default_mob.has_item?(@fork)
  end

  def test_removal
    @default_mob.remove_item(@fork)

    assert_empty @default_mob.items
    refute_includes @default_mob.items, @fork
  end

  def test_transfer
    @default_mob.move_item(@custom_mob, @fork)

    assert @custom_mob.has_item?(@fork), "@custom_mob has not received @fork"
    assert_equal false, @default_mob.has_item?(@fork)
  end
end
