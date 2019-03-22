require 'colorize'
require "byebug"
require_relative "tile"

class Board

    def initialize(size)
      @num_of_flags = ((size * size) * 0.123).round
      @grid = populate_grid(size)
    end 

    def [](pos)
      x, y = pos 
      @grid[x][y]
    end 

    def []=(pos, value)
      x, y = pos
      @grid[x][y] = value 
    end 

    def render
      system("clear")
        if @num_of_flags == 1
          puts  "#{@num_of_flags}".colorize(:red) + " Flag".bold
        else
          puts "#{@num_of_flags}".colorize(:red) + " Flags".bold
        end 
        puts "  #{(0..8).to_a.join(" ").colorize(:light_cyan).underline}"
        @grid.each_with_index do |row, i|
          puts "#{i}".colorize(:light_cyan) + "|" + "#{row.join(" ")}"
        end 
    end 

    def a_bomb?(pos)
      self[pos].bomb?
    end 

    def flagged?(pos, val)
      self[pos].flagged? 
    end 

    def flag(pos, val)
      self[pos].flag
    end 

    def unflag(pos, val)
      self[pos].unflag
    end 

    def reveal(pos, val)
      #if flagged do not reveal
      #if a number only reveal that tile
      #if '_' reveal surrounding tiles not at a diagnol that have the same value 

    def game_won?
      @grid.each_with_index do |subArr, x|
        subArr.each_with_index do |ele, y|
          if !@grid[x][y].bomb? && !@grid[x][y].revealed?  
            return false
           end 
        end 
       end 
      true
    end 

    def populate_grid(size)
      @grid = form_grid(size) 
      rand_bomb_placement(@grid)
      nums_dashes_to_grid(@grid)
    end 

    def form_grid(size)
        Array.new(size) do 
            Array.new(size) {|ele| Tile.new}
        end 
    end 

    def rand_bomb_placement(bomb_grid) 
      size = bomb_grid.length
      bombs = @num_of_flags  
        while bombs >= 1
            x, y = [rand(0..8), rand(0..8)]
            if  bomb_grid[x][y].value == nil
                bomb_grid[x][y].value = "*"
                bombs -= 1
            end 
        end  
    end 

    def nums_dashes_to_grid(populated_grid)
        board = populated_grid
        board.each_with_index do |subArr, x|
            subArr.each_with_index do |ele, y|
                if !board[x][y].bomb?
                    value = check_surrounding_squares(board, [x, y])
                    board[x][y].value = value
                end 
            end 
        end 
    end 

    def check_surrounding_squares(board, pos)
      x, y = pos 
      value = 0
      x_coor = [1,1,0,-1,-1,-1,0,1]
      y_coor = [0,1,1,1,0,-1,-1,-1]
         
        x_coor.zip(y_coor) do |pos_x, pos_y|
            if x + pos_x < board.length &&
                 y + pos_y < board.length &&
                  x + pos_x >= 0 &&
                   y + pos_y >= 0 &&
                    board[x+pos_x][y+pos_y].bomb? 
                value += 1
            end 
        end 
        value == 0 ? "_" : value 
    end 
           
private

attr_reader :grid


end 