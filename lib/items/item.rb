# The big mother of the item family.
# Items can be used directly with this, but should have a more specific
# type if possible because this doesn't really have much functionality.
class Item
  include lookable
  attr_accessor :name, :description

  def initialize(name = "Default Item",
                 description = <<-DESC
This item does nothing, as it is the default.
Or at least, the description is the default.
DESC
                )
    @name = name
    @description = description
  end
end
