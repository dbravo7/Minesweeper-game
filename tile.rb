require 'colorize'

class Tile

    def initialize(square)
        @value = square
        @bomb = square == "*" ? true : false 
        @revealed = false 
        @flagged = false 
    end 

    def bomb?
        @bomb
    end 

    def flagged?
        @flagged
    end 

    def flag
        @flagged = true 
    end 

    def unflag
        @flagged = false
    end 

    def reveal 
        @revealed = true 
    end 

    def revealed?
        @revealed
    end 

    def to_value
        revealed? ? @value : "?"
    end 



    # have to check whether the tile is flagged
    # will have to reveal the tile

end 