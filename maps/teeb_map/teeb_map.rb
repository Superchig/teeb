require_rel '../../lib'

## Map setup

# Rooms setup
bar_description = <<-EOT
It's a bar-ish type of bar. You know, the one that looks like a bar.
There's a way out up north. Not sure where it leads to, though.
EOT
bar = Room.new("Bar-Like Bar", bar_description)
outside = Room.new

bar.paths[:north] = outside
outside.paths[:south] = bar

# Mobs setup

dwarf_description = <<-EOT
A dwarf, as his name should state.
Average-size for a dwarf.
He has some chainmail armor, and a greataxe in his hands.
He looks passive.
EOT

player = Player.new("Player Character", "The player.", 150, 150, 150, 150)
dwarf = Mob.new("Dwarf", dwarf_description, 200, 200, 100, 100)

player.room = bar
dwarf.room = outside

bar.add_mob(player)
outside.add_mob(dwarf)

# Items setup

broken_watch = Item.new("Broken Watch", "A peculiar analog wristwatch. It is stuck at the time 4:20.")
spoon = Item.new("Spoon", "There is no spoon!")

player.room.add_item(broken_watch, spoon)

Menu.gen_loop(player)
