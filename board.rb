require "byebug"
require_relative "tile"

class Board

    def initialize(size)
        debugger 
        @grid = Board.create_grid(size)
        @tiles = create_tiles(@grid)
    end 

    def [](pos)
        x, y = pos 
        @grid[x][y]
    end 

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
        bomb_grid
    end 




end 