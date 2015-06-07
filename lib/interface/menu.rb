module Menu
  def self.credits
    puts "Written by superchig."
    puts "Thanks to all those who wrote the gems I use, and of course Ruby."
  end

  def self.start_prompt
    eval_choice = lambda do |choice|
      case choice
      when '1'
        puts "Game unfinished. Please look later."
        $stdin.gets.chomp
      when '2'
        credits
        $stdin.gets.chomp
      when '3'
        puts "Exiting..."
        false
      end
    end

    puts "Welcome to Teeb. A text-based adventure where you do... something."
    puts "I really have no idea what the point of this is. Just expect lots of grinding and almost no storyline.\n"

    loop do
      puts "\n"
      puts "Choices:"
      puts "1. Start game."
      puts "2. Credits."
      puts "3. Exit"
      puts "\n"

      print "> "

      choice = $stdin.gets.chomp
      break if eval_choice.call(choice) == false
    end
  end
end
