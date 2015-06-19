require_rel("../mixins/")

# The big mother of the item family.
# Items can be used directly with this, but should have a more specific
# type if possible because this doesn't really have much functionality.
class Item
  include Lookable
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

  def ==(other_item)
    @name == other_item.name && @description == other_item.description
  end

  def to_s
    "item: #{@name}; description: #{@description}"
  end
end
