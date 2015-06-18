# To mix-in for all stuff that can hold items
module Inventory
  attr_accessor :items

  def init_items(*items)
    @items = items
  end

  def add_item(*items_to_add)
    items_to_add.each { |item| @items.push(item) }
  end

  def remove_item(*items_to_remove)
    items_to_remove.each { |item| items_to_remove(item) }
  end

  def move_item(target_mob, *items_to_move)
    target_mob.add_item(*items_to_move)
    remove_item(*items_to_move)
  end
end
