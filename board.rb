require "byebug"
require_relative "tile"

class Board

    def self.create_grid(size)
        empty_grid = Array.new(size) {Array.new(size)}
        Board.rand_bomb_placement(empty_grid)
    end 

    def self.rand_bomb_placement(bomb_grid) 
        size = bomb_grid.length 
        num_of_bombs = ((size * size) * 0.123).round 

        while num_of_bombs >= 1
            x, y = [rand(0..8), rand(0..8)]
            if  bomb_grid[x][y] == nil
                bomb_grid[x][y] = "*"
                num_of_bombs -= 1
            end 
        end  
        Board.nums_dashes_to_grid(bomb_grid)
    end 

    def self.nums_dashes_to_grid(populated_grid)
        board = populated_grid
        board.each_with_index do |subArr, row|
            subArr.each_with_index do |ele, col|
                if board[row][col] != "*"
                    value = Board.check_surrounding_squares(board, [row, col])
                    board[row][col] = value
                end 
            end 
        end 
        board
    end 

    def self.check_surrounding_squares(board, pos)
        x, y = pos 
        value = 0
        x_coor = [1,0,-1,-1,0,0,1,1]
        y_coor = [0,1,0,0,-1,-1,0,0]

        x_coor.zip(y_coor) do |pos_x, pos_y|
            if x + pos_x < board.length &&
                 y + pos_y < board.length &&
                  x + pos_x >= 0 &&
                   y + pos_y >= 0 &&
                    board[x+pos_x][y+pos_y] == "*"
                value += 1
            end 
        end 
        value == 0 ? "_" : value 
    end 

    def self.create_tiles(board)
        tiles = board.map do |row|
                 row.map {|ele| Tile.new(ele)}
        end 
        tiles
    end 

    def initialize(size)
        @grid = Board.create_grid(size)
        @tiles = Board.create_tiles(@grid)
        render 
        debugger 
    end 

    def [](pos)
        x, y = pos 
        @grid[x][y]
    end 

    def render
        puts "  #{(0..8).to_a.join(" ")}"
        @grid.each_with_index do |row, i|
            puts "#{i} #{row.join(" ")}"
        end 
    end 

    
           
private

attr_reader :grid, :tiles 


end 