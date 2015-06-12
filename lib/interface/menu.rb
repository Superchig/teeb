require_rel 'movement.rb'

# Basically the start menu
# Prompts and choices may be put in a different module
module Menu
  module_function

  def credits
    puts "Written by superchig."
    puts "Thanks to all those who wrote the gems I use, and of course Ruby."
  end

  def welcome_message
    puts "Welcome to Teeb. A text-based adventure where you do... something."
    puts "I really have no idea what the point of this is. Just expect lots of grinding and almost no storyline.\n"
  end

  def adventures_menu
    puts "Which adventure would you like?\n"

    puts "1. Teeb (the default)"
    puts "2. Exit (not an adventure)"

    choice = $stdin.gets.chomp
    eval_adventures(choice)

    puts ""
  end

  def eval_adventures(choice)
    case choice
    when '1'
      load_rel '../../maps/teeb_map/teeb_map.rb'
    when '2'
      puts "Leaving adventures menu."
    end
  end

  def eval_choice(choice)
    case choice
    when '1'
      adventures_menu
      $stdin.gets.chomp
    when '2'
      credits
      $stdin.gets.chomp
    when '3'
      puts "Exiting..."
      false
    end
  end

  def start_loop
    loop do
      puts "\n"
      puts "Choices:"
      puts "1. Start game."
      puts "2. Credits."
      puts "3. Exit"
      puts "\n"

      print "> "

      choice = $stdin.gets.chomp
      break if eval_choice(choice) == false
    end
  end

  def start_prompt
    welcome_message

    start_loop
  end

  def prompt
    Movement.show_room

    print "> "

    choice = $stdin.gets.chomp
    Movement.eval_move(choice)
  end
end
