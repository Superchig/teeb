# To mix-in for all stuff that can hold items.
# Each item used is a reference to an Item object, not a string with the name of
# the item.
module Inventory
  attr_accessor :items

  def init_items(items)
    @items = items
  end

  def add_item(*items_to_add)
    items_to_add.each { |item| @items.push(item) }
  end

  def remove_item(*items_to_remove)
    items_to_remove.each { |item| @items.delete(item) }
  end

  def move_item(target_mob, *items_to_move)
    items_to_move.each do |item|
      target_mob.add_item(item)
      remove_item(item)
    end
  end

  # rubocop:disable Style/PredicateName
  def has_item?(target)
    @items.include?(target)
  end
  # rubocop:enable Style/PredicateName

  def drop_item(item)
    room.add_item(item)
    remove_item(item)
  end
end
