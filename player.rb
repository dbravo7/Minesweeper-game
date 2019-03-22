class Player

    def initialize(name)
        @name = name
    end 

    def prompt_pos 
        puts "Please enter coordinates for the tile you would like to reveal or place a flag on (e.g. 2,4)"
        puts ""
    end 

    def prompt_val
        puts "Enter 'f' for flag, 'u' for unflag, or 'r' for reveal"
        puts ""
    end 

    def get_pos
        prompt_pos
        gets.chomp
    end 

    def get_val
        prompt_val
        gets.chomp
    end 

end