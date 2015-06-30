require 'rainbow'

require_rel 'mob.rb'

# Allows for more abstract conversion from string to regexp
class String
  def to_regexp
    /#{Regexp.quote(self)}/
  end
end

# Conversion to more displayed string
class Array
  def to_output_string
    map(&:name).join(', ')
  end

  def debug_show
    each { |item| puts item }
  end
end

# Has player-only specifics
class Player < Mob
  def show_items
    empty_message = Rainbow("You have no items in your immediate inventory.").color(:yellow)

    return puts empty_message if @items.empty?

    items_string = @items.to_output_string
    items_string = Rainbow(items_string).color(:yellow)

    puts Rainbow("Inventory:").underline.color(:yellow) << " " << items_string
  end

  WEARING_COLOR = "#0000FF"

  def show_wearing
    not_wearing = Rainbow("You're not wearing anything.").color(WEARING_COLOR)

    return puts not_wearing if @equipment.empty?

    equipment_string = @equipment.map { |_placement, wearable| wearable.name }.join(", ")

    col_und_wearing = Rainbow("Wearing:").color(WEARING_COLOR).underline

    colored_equipment = Rainbow(" #{equipment_string}").color(WEARING_COLOR)

    puts col_und_wearing << colored_equipment
  end

  def show_inventory
    show_items
    show_wearing
  end

  def check_for_lookable_name(lookable_name) # Can be refactored to be shorter, though perhaps not as readable.
    # Can also be refactored into separate methods for each block. Tried to do so, but failed.
    lookable = false

    check_lookable = proc do |poss|
      lookable_exists = poss.name.downcase =~ lookable_name.to_regexp
      lookable = poss if lookable_exists
    end

    @room.mobs.each(&check_lookable)

    @room.items.each(&check_lookable)

    @items.each(&check_lookable)

    @room.paths.each do |path, room|
      lookable_exists = path.to_s.downcase =~ lookable_name.to_regexp
      lookable = room if lookable_exists
    end

    lookable
  end

  def eval_look(to_look)
    return @room.show if to_look.empty?

    to_look.slice!(" ")
    look_at(to_look)
  end

  def look_at(lookable_name)
    cannot_look_message = "You cannot see #{lookable_name}. Is it even here?"
    lookable = check_for_lookable_name(lookable_name)
    lookable ? (puts lookable.show) : (puts cannot_look_message)
  end

  def eval_get(item_name)
    return_item = false

    @room.items.each { |item| return_item = item if item.name.downcase =~ item_name.to_regexp  }

    return_item
  end

  def get_item(item_name, player)
    return puts "USAGE: get [item]" if item_name.empty? || item_name == "get"

    item = eval_get(item_name)
    if item
      player.room.move_item(player, item)
      puts "You get #{item.name}."
    else
      puts "You can't get #{item_name}."
    end
  end

  def eval_wear(wearable_name)
    usage_message = "USAGE: wear [wearable]"
    usage_error = wearable_name.empty? || wearable_name == "wear"

    return puts usage_message if usage_error

    wearable = false

    wearable_regexp = wearable_name.to_regexp

    check_items = proc { |item| wearable = item if item.name.downcase =~ wearable_regexp && item.is_a?(Wearable) }

    @items.each(&check_items)

    @room.items.each(&check_items)

    wearable ? wear(wearable) : (puts "You can't wear #{wearable_name}.")
  end

  def convert_to_remove(wearable_string)
    to_remove_array = []
    if wearable_string.include?(',')
      @equipment.each do |_p, wearable|
        wearable_string.split(', ').each do |inner_wearable|
          name_matches = wearable.name.downcase =~ inner_wearable.to_regexp
          to_remove_array.push(wearable) if name_matches
        end
      end
      return to_remove_array
    else
      @equipment.each do |_p, wearable|
        return wearable if wearable.name.downcase =~ wearable_string.to_regexp
      end
    end
  end

  def class_eval_remove(to_remove, error_msg)
    if to_remove.is_a? Array
      if to_remove.empty?
        puts error_msg
      else
        remove_wearable(to_remove)
        puts "You removed #{to_remove.to_output_string}"
      end
    elsif to_remove.is_a? Wearable
      remove_wearable(to_remove)
      puts "You removed #{to_remove.name}"
    end
  end

  def eval_remove(wearable_string)
    usage_message = "USAGE: remove [wearable being worn]"
    usage_error = wearable_string.empty? || wearable_string == "remove"

    return puts usage_message if usage_error

    to_remove = convert_to_remove(wearable_string)

    not_wearing_error = "You're not wearing #{wearable_string}"

    class_eval_remove(to_remove, not_wearing_error)
  end

  def eval_drop(item_name)
    usage_message = "USAGE: drop [item]"
    usage_error = item_name.empty? || item_name == "drop"

    return puts usage_message if usage_error

    to_drop = false

    @items.each { |item| to_drop = item if item.name.downcase =~ item_name.to_regexp }

    if to_drop
      drop_item(to_drop)
      puts "You dropped #{to_drop.name}."
    else
      puts "#{item_name} is not in your inventory."
    end
  end
end
