module Parser
  module_function

  ## Generic Parsing

  # rubocop:disable Metrics/CyclomaticComplexity
  def parse_com(choice, player)
    moved = Movement.parse_move(choice, player)

    parse_str = choice.dup

    case choice
    when /^look/
      parse_str.slice!(/^look/)
      parse_str = "l" + parse_str
      parse_str.slice!(/^l /)
      parse_look(player, parse_str)
    when /^l/
      parse_str.slice!(/^l /)
      parse_look(player, parse_str)
    when "get gud scrub", "git gud scrub"
      puts "You found this, huh. Did you look at the source code?"
      puts "That was a rhetorical question. I'm too lazy to add a prompt and conditionals here."
    when /^get/
      parse_str.slice!(/^get /)
      parse_get(player, parse_str)
    when 'i'
      player.show_inventory
    when /^wear/
      parse_str.slice!(/^wear /)
      parse_wear(player, parse_str)
    when /^remove/
      parse_str.slice!(/^remove /)
      parse_remove(player, parse_str)
    when /^drop/
      parse_str.slice!(/^drop /)
      player.parse_drop(parse_str)
    else
      puts "#{choice} is not a valid command."
    end unless moved # Don't run the case statement if the player moved.
  end
  # rubocop:enable Metrics/CyclomaticComplexity

  ## Specific Command Parsing
  ##
  ## The most obvious ones take only the name of their object.

  def check_for_lookable_name(player, lookable_name) # Can be refactored to be shorter, though perhaps not as readable.
    # Can also be refactored into separate methods for each block. Tried to do so, but failed.
    lookable = false

    check_lookable = proc do |poss|
      lookable_exists = poss.name.downcase =~ lookable_name.to_regexp
      lookable = poss if lookable_exists
    end

    player.room.mobs.each(&check_lookable)

    player.room.items.each(&check_lookable)

    player.items.each(&check_lookable)

    player.room.paths.each do |path, room|
      lookable_exists = path.to_s.downcase =~ lookable_name.to_regexp
      lookable = room if lookable_exists
    end

    lookable
  end

  def parse_look(player, to_look)
    return player.room.show if to_look.empty? || to_look == "l"

    look_at(player, to_look)
  end

  def look_at(player, lookable_name)
    cannot_look_message = "You cannot see #{lookable_name}. Is it even here?"
    lookable = check_for_lookable_name(player, lookable_name)
    lookable ? (puts lookable.show) : (puts cannot_look_message)
  end

  def get_item(player, item_name)
    return_item = false

    player.room.items.each do |item|
      return_item = item if item.name.downcase =~ item_name.to_regexp
    end

    return_item
  end

  def parse_get(player, item_name)
    return puts "USAGE: get [item]" if item_name.empty? || item_name == "get"

    item = get_item(player, item_name)
    if item
      player.room.move_item(player, item)
      puts "You get #{item.name}."
    else
      puts "You can't get #{item_name}."
    end
  end

  def parse_wear(player, wearable_name)
    usage_message = "USAGE: wear [wearable]"
    usage_error = wearable_name.empty? || wearable_name == "wear"

    return puts usage_message if usage_error

    wearable = false

    wearable_regexp = wearable_name.to_regexp

    check_items = proc do |item|
      wearable = item if item.name.downcase =~ wearable_regexp && item.is_a?(Wearable)
    end

    player.items.each(&check_items)

    player.room.items.each(&check_items)

    wearable ? player.wear(wearable) : (puts "You can't wear #{wearable_name}.")
  end

  # Internal: Takes a string and converts it into an array of references to
  # Items in the player's equipment, split by ', '.
  #
  # player          - The Player whose equipment is checked for items.
  # wearable_string - The String holding the (partial) names of items to find in
  #                   player's equipment.
  #
  # Examples
  #
  #   convert_to_remove(player, "Hat, Socks, Glasses")
  #   # => []
  #
  # Returns the array of Items.
  def convert_to_remove(player, wearable_string)
    to_remove_array = []
    if wearable_string.include?(',')
      player.equipment.each do |_p, wearable|
        wearable_string.split(', ').each do |inner_wearable|
          name_matches = wearable.name.downcase =~ inner_wearable.to_regexp
          to_remove_array.push(wearable) if name_matches
        end
      end

      to_remove_array
    else
      player.equipment.each do |_p, wearable|
        return wearable if wearable.name.downcase =~ wearable_string.to_regexp
      end
    end
  end

  def class_parse_remove(player, to_remove, error_msg)
    if to_remove.is_a? Array
      if to_remove.empty?
        puts error_msg
      else
        player.remove_wearable(to_remove)
        puts "You removed #{to_remove.to_output_string}"
      end
    elsif to_remove.is_a? Wearable
      remove_wearable(to_remove)
      puts "You removed #{to_remove.name}"
    end
  end

  def parse_remove(player, wearable_string)
    usage_message = "USAGE: remove [wearable being worn]"
    usage_error = wearable_string.empty? || wearable_string == "remove"

    return puts usage_message if usage_error

    to_remove = convert_to_remove(player, wearable_string)

    not_wearing_error = "You're not wearing #{wearable_string}"

    class_parse_remove(player, to_remove, not_wearing_error)
  end
end
