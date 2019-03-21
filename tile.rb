require 'colorize'

class Tile

    def initialize(square)
        @tile = square
        @value = square == "*" ? true : false 
    end 

    def bomb?
        @value
    end 

    # have to check whether the tile is flagged
    # will have to reveal the tile

end 