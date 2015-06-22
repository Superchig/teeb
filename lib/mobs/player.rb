require_rel 'mob.rb'
require_rel '../interface/movement.rb'

# Has player-only specifics
class Player < Mob
  def show_items
    if @items.empty?
      puts "You have no items in your immediate inventory."
      return nil
    end

    items_string = @items.map(&:name).join(", ")

    puts "Inventory: #{items_string}"
  end

  def show_wearing
    return puts "You're not wearing anything." if @equipment.empty?

    equipment_string = @equipment.map { |_placement, wearable| wearable.name }.join(", ")

    puts "Wearing: #{equipment_string}"
  end

  def show_inventory
    show_items
    show_wearing
  end

  def check_for_lookable_name(lookable_name) # Can be refactored to be shorter, though perhaps not as readable.
    # Can also be refactored into separate methods for each block. Tried to do so, but failed.
    @room.mobs.each do |mob|
      lookable_name_exists = mob.name.downcase == lookable_name
      return mob if lookable_name_exists
    end

    @room.items.each do |item|
      lookable_name_exists = item.name.downcase == lookable_name
      return item if lookable_name_exists
    end

    @items.each do |item|
      lookable_name_exists = item.name.downcase == lookable_name
      return item if lookable_name_exists
    end

    false
  end

  def eval_look(to_look)
    if to_look.empty?
      @room.show
    else
      to_look.slice!(" ")
      look_at(to_look)
    end
  end

  def look_at(lookable_name)
    cannot_look_message = "You cannot see #{lookable_name}. Is it even here?"
    lookable = check_for_lookable_name(lookable_name)
    lookable ? (puts lookable.show) : (puts cannot_look_message)
  end

  def eval_get(item_name)
    return_item = false

    @room.items.each { |item| return_item = item if item.name.downcase == item_name }

    return_item
  end

  def get_item(item_name, player)
    if item_name.empty? || item_name == "get"
      puts "USAGE: get [item]"
      return nil
    end

    item = eval_get(item_name)
    if item
      player.room.move_item(player, item)
      puts "You get #{item_name}."
    else
      puts "You can't get #{item_name}."
    end
  end

  def eval_wear(wearable_name)
    return puts "USAGE: wear [wearable]" if wearable_name.empty? || wearable_name == "wear"

    wearable = false

    check_items = proc { |item| wearable = item if item.name.downcase == wearable_name && item.is_a?(Wearable) }

    @items.each(&check_items)

    @room.items.each(&check_items)

    wearable ? wear(wearable) : (puts "You can't wear #{wearable_name}.")
  end

  def eval_remove(wearable_name)
    return puts "USAGE: remove [wearable being worn]" if wearable_name.empty? || wearable_name == "remove"

    to_remove = false

    @equipment.each { |_placement, wearable| to_remove = wearable if wearable.name.downcase == wearable_name }

    to_remove ? remove_wearable(to_remove) : (puts "You're not wearing #{wearable_name}")
  end
end
