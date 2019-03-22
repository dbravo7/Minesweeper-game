require "byebug"
require_relative "board"
require_relative "player"

class Minesweep

attr_reader :player, :board

    def initialize(name, size)
        @player = Player.new(name)
        @board = Board.new(size)
        run_game 
    end 

    def run_game
        play_turn until game_won?
        puts "Congratulations, you won!!!"
    end 

    def play_turn
        @board.render 
        pos = get_pos
        val = get_val
        # whether the position is now flagged and how many flags left
        # whether position is now unflagged 
        # whether the position is a bomb and then game over
        # reveal position 
    end 

    def gets_pos
        pos = nil
        until pos && position_valid?(pos)
            @board.render 
            pos = player.get_pos
        end
        pos  
    end 

    def get_val 
        val = nil 
        until val && value_valid?(pos)
            val = player.get_val
        end
    end 

    def position_valid?(pos)
        formatted_pos = []
        coord = pos.split(",")
        coord.each do |ele|
            if /[azAZ]/.match?(ele) || coord.length != 2 || 
                    ele.to_i > 8 || ele.to_i < 0
                puts "Choose numbers between 0 and 8 and be sure to add a comma between the numbers"
                sleep(1.5)
                return false 
            else 
                formatted_pos << ele 
            end 
        end 
        formatted_pos
    end 
    
    def value_valid?(pos)
    end 

end 

if $PROGRAM_NAME == __FILE__
    Minesweep.new("David", 9)
end 