require_rel '../../lib'

## Map setup

# Rooms setup
bar_description = <<-EOT
It's a bar-ish type of bar. You know, the one that looks like a bar.
There's a way out up north. Not sure where it leads to, though.
EOT
bar = Room.new("Bar-Like Bar", bar_description)

hub_desc = <<DESC
A hub, leading in all sorts of directions.
There are paths to the south and the east.
DESC
hub = Room.new("Center Hub", hub_desc)

bar.paths[:north] = hub
hub.paths[:south] = bar

# - Never-ending hallway setup.
hall_bottom_desc = <<DESC
A dimly-lit room. Candles are placed somewhat randomly around it.
There is a continuation to the north, and a path back to the hub to the west.
Oddly enough, there's also a path to the south. Someone's there.
DESC
hall_bot = Room.new("Never-ending Hallway Bottom", hall_bottom_desc)

hall_mid_1_desc = <<DESC
A fairly bright room. There's actually a lightbulb. Hurray.
There's a path to the south and the north.
DESC
hall_mid_1 = Room.new("Hallway Middle 1", hall_mid_1_desc)

hall_mid_2_desc = <<DESC
It's really bright in this room. Seriously. You have to squint to retain quality in your retinas.
There's a path to the south and the north.
DESC
hall_mid_2 = Room.new("Hallway Middle 2", hall_mid_2_desc)

hall_end_desc = <<DESC
This room is almost pitch-black. Huh.
There are paths to the north and south.
DESC
hall_end = Room.new("Hallway End", hall_end_desc)

hub.paths[:east] = hall_bot

hall_bot.paths[:north] = hall_mid_1
hall_bot.paths[:west] = hub
hall_bot.paths[:south] = hall_end

hall_mid_1.paths[:north] = hall_mid_2
hall_mid_1.paths[:south] = hall_bot

hall_mid_2.paths[:north] = hall_end
hall_mid_2.paths[:south] = hall_mid_1

hall_end.paths[:north] = hall_bot
hall_end.paths[:south] = hall_mid_2

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
dwarf.room = hub

bar.add_mob(player)
hub.add_mob(dwarf)

# Items setup

gold_watch = Wearable.new("Gold Watch", "A beautiful, diamond-encrusted Nike knock-off.",
                          :left_wrist)
spoon = Item.new("Spoon", "There is no spoon!")
usel_lamp = Furniture.new("Useless Lamp", "This lamp cannot do anything.")

player.room.add_item(gold_watch, spoon)

derpy_fed = Wearable.new("Derpy Fedora", "You have no idea what derpy means.", :head)

musty_t_desc = <<DESC
This does not have an unusual odor, despite what its name suggests.
Rather, it seems slightly dated and apathetic.
In fact, it has some sort of odd lettering on it. It shows S-CRY-ed.
DESC
musty_t = Wearable.new("Musty T-Shirt", musty_t_desc, :body)

fant_pants = Wearable.new("Fantastic Pants", "These pants are simply phenomenal.",
                          :legs)

broken_watch = Wearable.new("Broken Watch", "A peculiar analog wristwatch. It is stuck at the time 4:20.",
                            :left_wrist)

player.wear(derpy_fed)
player.wear(fant_pants)
player.wear(broken_watch)
player.wear(musty_t)

Menu.gen_loop(player)
