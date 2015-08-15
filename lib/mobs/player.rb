require 'rainbow'

require_rel 'mob.rb'

# Allows for more abstract conversion from string to regexp.
class String
  def to_regexp
    /#{Regexp.quote(self)}/
  end
end

# Conversion to more displayed string.
class Array
  def to_output_string
    map(&:name).join(', ')
  end

  def debug_show
    each { |item| puts item }
  end
end

# Has player-only specifics.
# Due to poor design choices, it's mainly a pseudo-parser for each command.
# In the process of refactoring.
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
