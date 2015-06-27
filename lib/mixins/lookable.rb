require 'rainbow'

# Anything that can be looked at should include this
module Lookable
  def show
    puts Rainbow(@name).color(:blue).bright
    puts @description
  end
end
