require 'require_all'
require 'minitest/autorun'

require_rel '../lib/items'
require_rel '../lib/mobs'

# Tests out the ownership and removal of wearables.
class TestWearable < Minitest::Test
  def setup
    @mob1 = Mob.new("Mob 1", "A test mob.")

    sme_band_desc = <<-DESC
A dark blue bandana.
It has an odd, lingering odor, like that of a burning, cardboard skunk that spent
an entire weekend hanging out with racoons and searching through trash.
DESC
    @sme_band = Wearable.new("Smelly Bandana", sme_band_desc,
                             :head)

    @mob1.wear(@sme_band)
  end

  def test_wearing
    assert @mob1.wearing?(@sme_band), "@mob1 is not wearing @sme_band"
  end

  def test_removal
    @mob1.remove_wearable(@sme_band)
    refute @mob1.wearing?(@sme_band), "@mob1 is still wearing @sme_band, even after removal."
    assert @mob1.has_item?(@sme_band), "@sme_band has not been returned to @mob1's inventory."
  end
end
