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
        play_turn unless game_won?
        puts "Congratulations, you won!!!"
    end 


end 

if $PROGRAM_NAME == __FILE__
    Minesweep.new("David", 9)
end 