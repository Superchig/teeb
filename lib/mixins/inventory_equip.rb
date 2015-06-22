# Adds and manages the equipment hash.
# Works with objects that include Inventory.
module InventoryEquipment
  attr_accessor :equipment

  def wearing?(wearable)
    equipment[wearable.placement]
  end

  def wearing_on?(placement)
    equipment[placement]
  end

  def basic_wear(wearable)
    equipment[wearable.placement] = wearable
  end

  def remove_wearable(wearable)
    p equipment[wearable.placement]
    add_item(equipment[wearable.placement].dup)
    equipment.delete(wearable.placement)
    puts "You removed #{wearable.name}"
  end

  def wear(wearable)
    return puts "You are already wearing #{equipment[wearable.placement].name}" if wearing? wearable

    basic_wear(wearable)
    remove_item(wearable) if has_item? wearable
    puts "You wear #{wearable.name}"
  end
end
