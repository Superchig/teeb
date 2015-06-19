# To mix-in for all stuff that can hold items
module Inventory
  attr_accessor :items

  def init_items(items)
    @items = items
  end

  def add_item(*items_to_add)
    # items_to_add.each { |item| @items.push(item) }
    items_to_add.each do |item|
      @items.push(item)
    end
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

  def has_item?(target)
    @items.include?(target)
  end
end
