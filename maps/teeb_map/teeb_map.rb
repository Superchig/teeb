require_rel '../../lib'

## Map setup

# Variable declaration
bar_description = <<-EOT
It's a bar-ish type of bar. You know, the one that looks like a bar.
There's a way out up north. Not sure where it leads to, though.
EOT
bar = Room.new("Bar-Like Bar", bar_description)
outside = Room.new

dwarf_description = <<-EOT
A dwarf, as his name should state.
Average-size for a dwarf.
He has some chainmail armor, and a greataxe in his hands.
He looks passive.
EOT
player = Mob.new("Player Character", "The player.", 150, 150, 150, 150)
dwarf = Mob.new("Dwarf", dwarf_description, 200, 200, 100, 100)

# Rooms setup
bar.paths[:north] = outside
outside.paths[:south] = bar

bar.add_mob(player)
outside.add_mob(dwarf)

# Mobs setup
player.room = bar
dwarf.room = outside

Menu.gen_loop(player)
