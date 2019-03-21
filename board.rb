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
        empty_grid
    end 





end 