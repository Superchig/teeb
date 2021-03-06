require_rel '../mixins/'

# A Room holds references to the rooms surrounding it,
# and has an array, mobs, which holds references to the
# mobs in the room.
class Room
  include Lookable
  include Inventory

  attr_accessor :name, :description
  attr_reader :mobs, :paths

  def initialize(name = "Default Room", description = "This is the default room description", \
                 mobs = [], paths = {}, items = [], furniture = [])
    @name = name
    @description = description
    @mobs = mobs
    @paths = paths
    init_items(items)
    @furniture = furniture
  end

  def add_mob(*mobs)
    mobs_to_be_added = mobs
    mobs_to_be_added.each do |mob|
      @mobs.push(mob)
      mob.room = self
    end
  end

  def remove_mob(*mobs_for_deletion)
    mobs_to_be_deleted = mobs_for_deletion
    mobs_to_be_deleted.each do |mob|
      mob_index = @mobs.find_index(mob)

      mob_index.nil? ? (puts "Doh! Mob not found.") : (@mobs.delete_at(mob_index))
    end
  end

  MOBS_COLOR = :red

  def show_mobs
    mobs_str_beg = Rainbow("Mobs:").color(MOBS_COLOR).underline
    mobs_string = @mobs.map(&:name).join(', ')
    mobs_string = Rainbow(mobs_string).color(MOBS_COLOR)

    puts mobs_str_beg << " " << mobs_string
  end

  ITEMS_COLOR = "#00CC99"

  def show_items
    output = Rainbow("Room Items:").color(ITEMS_COLOR).underline

    room_items = @items.map do |item|
      if item.is_a? Furniture
        item.name unless item.placed
      elsif item.is_a? Item
        item.name
      else
        "Error. An 'item' was, oddly enough, neither an item nor furniture."
      end
    end.join(', ')

    output << " " << Rainbow(room_items).color(ITEMS_COLOR)

    puts output
  end

  def add_furniture(*furniture_to_add)
    furniture_to_add.each do |furn|
      @furniture.add(furn)
      remove_item(furn)
    end
  end

  def remove_furniture(*furniture_to_remove)
    furniture_to_remove.each { |furn| @furniture.delete(furn) }
  end

  def show
    super

    unseen_message = "You do not see anyone else here."

    @mobs.empty? ? (puts unseen_message) : show_mobs
    show_items unless @items.empty?
  end
end
