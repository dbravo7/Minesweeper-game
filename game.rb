require "byebug"
require_relative "board"
require_relative "player"

class Minesweep

attr_reader :player, :board

    def initialize(name, size)
        @player = Player.new(name)
        @board = Board.new(size)
        debugger 
        run_game 
    end 

    def run_game
        play_turn until board.game_won?
        puts "Congratulations, you won!!!"
    end 

    def play_turn
        @board.render 
        pos = get_pos #coordinate 
        val = get_val #f, u, r
        # whether the position is a bomb and then game over
        board.game_over?(pos)
        # whether the position is now flagged and how many flags left
        board.flagged?
        # whether position is now unflagged 
        # reveal position 
    end 

    def get_pos
        pos = nil
        until pos && position_valid?(pos)
            @board.render 
            pos = player.get_pos
        end
        pos  
    end 

    def get_val 
        val = nil 
        until val && value_valid?(val)
            val = player.get_val
        end
    end 

    def position_valid?(pos)
        coord = pos.split(",")
        if coord.length != 2
            player.prompt_invalid_pos
            return false
        end 
        formatted_pos = []
        coord.each do |ele|
            if !(/[0-8]/.match?(ele)) || ele.length > 1
                player.prompt_invalid_pos
                return false 
            else 
                formatted_pos << ele 
            end 
        end 
        formatted_pos
    end 

    def value_valid?(val)
        valid_choices = "rfu"
        val.length == 1 && valid_choices.include?(val.downcase)
    end 


end 

if $PROGRAM_NAME == __FILE__
    Minesweep.new("David", 9)
end 