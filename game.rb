require "byebug"
require 'colorize'
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
        pos = get_pos  
        val = get_val 
        game_over?(pos)
        board.a_flag?(pos, val)
        board.reveal(pos,val)
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

    def game_over?(pos)
      if board.a_bomb?(pos)
        raise "Oh, that is a bomb. You lose. Better luck next time".colorize(:light_blue ).colorize( :background => :red).bold 
      end 
    end 

    def a_flag?(pos, val)
      if val.downcase == "f" && board.flagged?(pos,val)
        puts "A flag is already at that location. To unflag use 'u'"
        sleep(2.3)
        play_turn
      else
        board.flag(pos, val)
      end 

      if val.downcase == "u" && board.flagged?(pos,val)
        board.unflag(pos,val)
      end 
    end 


end 

if $PROGRAM_NAME == __FILE__
    Minesweep.new("David", 9)
end 