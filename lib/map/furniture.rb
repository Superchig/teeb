require 'require_all'
require_rel '../items/item.rb'

# An Item that can be placed into a room.
# Yes, it can be picked up.
class Furniture < Item
  attr_reader :placed
  DEFAULT_DESCRIPTION = <<-DESC
This furniture does nothing, as it is the default.
Or at least, the description is the default.
DESC

  def initialize(name = "Default Item",
                 description = DEFAULT_DESCRIPTION,
                 placed = true
                )
    super(name, description)
    @placed = placed
  end
end
