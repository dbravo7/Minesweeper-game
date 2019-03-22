require 'colorize'

class Tile

    def initialize
        @value = nil 
        @revealed = false 
        @flagged = false 
    end 

    def inspect
        @value
    end 

    def bomb?
        @bomb = @value == "*" ? true : false 
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

    def to_s
        return "F" if flagged? else revealed? ? @value.to_s : "?"
    end 

    attr_accessor :value, :bomb, :flagged, :revealed

end 