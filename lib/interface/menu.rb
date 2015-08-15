require_rel 'movement.rb'
require_rel 'parser.rb'

# The start menu, and the prompts that receive player input.
# Only start_prompt should really be public.
module Menu
  module_function

  def start_prompt
    welcome_message

    start_loop
  end

  def gen_loop(player)
    player.room.show

    loop do
      prompt(player)
    end
  end

  def prompt(player)
    print "> "

    choice = $stdin.gets.chomp
    Parser.parse_com(choice.downcase, player)
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
      break if parse_choice(choice) == false
    end
  end

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
    parse_adventures(choice)

    puts ""
  end

  def parse_adventures(choice)
    case choice
    when '1'
      load_rel '../../maps/teeb_map/teeb_map.rb'
    when '2'
      puts "Leaving adventures menu."
    end
  end

  def parse_choice(choice)
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

  public :start_prompt, :gen_loop
end
