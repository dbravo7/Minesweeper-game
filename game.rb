require "byebug"
require_relative "board"
require_relative "player"

class Minesweep

attr_reader :player, :board

    def initialize(name, size)
        @player = name 
        @board = Board.new(size)
        run_game 
    end 



    def run_game
        

end 

if $PROGRAM_NAME == __FILE__
    Minesweep.new("David", 9)
end 