require_rel "item.rb"

# Wearable are items that you can wear.
class Wearable < Item
  attr_accessor :placement

  # There are many areas for wearables to be worn, at least for humanoids.
  #   :head, :body, :legs, :shoes, :left_wrist, :right_wrist, :left_hand, :right_hand

  def initialize(name = "Generic Wearable",
                 description = "A default wearable.",
                 placement = :left_wrist)
    super(name, description)
    @placement = placement
  end
end
