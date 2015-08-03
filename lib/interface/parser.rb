module Parser
  module_function

  ## Generic Parsing

  # rubocop:disable Metrics/CyclomaticComplexity
  def eval_com(choice, player)
    moved = Movement.eval_move(choice, player)

    eval_str = choice.dup

    case choice
    when /^l/
      eval_str.slice!(/^l/)
      eval_look(player, eval_str)
    when "get gud scrub", "git gud scrub"
      puts "You found this, huh. Did you look at the source code?"
      puts "That was a rhetorical question. I'm too lazy to add a prompt and conditionals here."
    when /^get/
      eval_str.slice!(/^get /)
      player.get_item(eval_str, player)
    when 'i'
      player.show_inventory
    when /^wear/
      eval_str.slice!(/^wear /)
      player.eval_wear(eval_str)
    when /^remove/
      eval_str.slice!(/^remove /)
      player.eval_remove(eval_str)
    when /^drop/
      eval_str.slice!(/^drop /)
      player.eval_drop(eval_str)
    else
      puts "#{choice} is not a valid command"
    end unless moved # Don't run the case statement if the player moved
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

  def eval_look(player, to_look)
    return player.room.show if to_look.empty?

    to_look.slice!(" ")
    look_at(player, to_look)
  end

  def look_at(player, lookable_name)
    cannot_look_message = "You cannot see #{lookable_name}. Is it even here?"
    lookable = check_for_lookable_name(player, lookable_name)
    lookable ? (puts lookable.show) : (puts cannot_look_message)
  end
end
