require 'colorize'
require "byebug"
require_relative "tile"

class Board

    def initialize(size)
        @grid = Array.new(size) {Array.new(size)}
        @num_of_bombs = ((size * size) * 0.123).round 
        populate_grid
        render 
        debugger 
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
        puts "  #{(0..8).to_a.join(" ").colorize(:light_cyan).underline}"
        @grid.each_with_index do |row, i|
            puts "#{i}".colorize(:light_cyan) + "|" + "#{row.join(" ")}"
        end 
    end 

    def game_won?
        # all squares besides bombs are revealed
        @grid.each_with_index do |subArr, x|
            subArr.each_with_index do |ele, y|
                if @grid[x][y] != "*" && !@grid[x][y].revealed?  
                    false
                end 
            end 
        end 
        true
    end 

        end 
    end 

    def populate_grid
        rand_bomb_placement(@grid)
        debugger 
        nums_dashes_to_grid(@grid)
    end 

    def rand_bomb_placement(bomb_grid) 
        size = bomb_grid.length
        bombs = @num_of_bombs.dup  
        debugger 
        while bombs >= 1
            x, y = [rand(0..8), rand(0..8)]
            if  bomb_grid[x][y] == nil
                bomb_grid[x][y] = Tile.new("*")
                bombs -= 1
            end 
        end  
    end 

    def nums_dashes_to_grid(populated_grid)
        board = populated_grid
        debugger 
        board.each_with_index do |subArr, x|
            subArr.each_with_index do |ele, y|
                if board[x][y] != "*"
                    value = check_surrounding_squares(board, [x, y])
                    board[x][y] = value
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
                    board[x+pos_x][y+pos_y] == "*"
                value += 1
            end 
        end 
        value == 0 ? Tile.new("_") : Tile.new(value) 
    end 
           
private

attr_reader :grid


end 