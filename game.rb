require "byebug"
require 'colorize'
require 'yaml'
require 'benchmark'
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
      play_turn until board.game_won?
        puts "Congratulations, you won!!!".colorize(:color=>light_blue, :background=>white)
        timer 
    end 

    def play_turn
    debugger 
      @board.render 
      pos = get_pos  
      val = get_val
      # timer  
        if val == "f" || val == "u"
          a_flag?(pos, val)
        else 
          board.reveal(pos,val)
          @board.render 
          game_over?(pos, val)
        end 
    end 

    def get_pos
        pos = nil
        until pos && position_valid?(pos)
            @board.render 
            pos = player.get_pos
        end
        pos.map {|num| Integer(num)}  
    end 

    def get_val 
        val = nil 
        until val && value_valid?(val)
            val = player.get_val
        end
        val.downcase
    end 

    def position_valid?(pos)
      if pos.length != 2
        player.prompt_invalid_pos
        return false
      end 
      formatted_pos = []
      pos.each do |ele|
        if !(/[0-8]/.match?(ele)) || ele.length > 1
          player.prompt_invalid_pos
          return false 
        end 
      end 
      true 
    end 

    def value_valid?(val)
      valid_choices = "rfu"
      val.length == 1 && valid_choices.include?(val.downcase)
    end 

    def game_over?(pos, val)
      if board.a_bomb?(pos) && val != "f" && val != "u"
        raise "Oh, that is a bomb. You lose. Better luck next time".colorize(:light_blue ).colorize( :background => :red).bold 
      end 
    end 

    def a_flag?(pos, val)
      if val == "u" && board.flagged?(pos) && !(board.num_of_flags == board.num_of_bombs)
        board.unflag(pos,val)
      end 

      if val == "f" && board.flagged?(pos)
        puts "A flag is already at that location. To unflag use 'u'"
        sleep(2.3)
        play_turn
      elsif val == "f" && board.num_of_flags == 0
        puts "There are no more flags. Unflag a location first to have a flag for use"
        sleep(2.3)
        play_turn 
      elsif val == "f" && board.num_of_flags > 0
        board.flag(pos, val)
      end 
    end 

  # def save_game
  #   File.open("save_game.yaml",'w') {|f| YAML.dump([] << self, f)}
  # end 

  # def load_game
  #   YAML.load_file("save_game.yaml").run_game
  # end 

#   def timer
#     t = Time.at(0)
#     puts "\nCompleted in #{(Time.at(0) - t)} seconds"
#   end
end 

if $PROGRAM_NAME == __FILE__
    Minesweep.new("David", 9) 
end 