class Player

    def initialize(name)
        @name = name
    end 

    def prompt_pos 
        puts ""
        puts "Please enter coordinates for the tile you would like to reveal or place a flag on (e.g. 2,4)"
    end 

    def prompt_val
        puts ""
        puts "Enter 'f' for flag, 'u' for unflag, or 'r' for reveal"
    end 
    
    def prompt_invalid_pos
        puts "Choose numbers between 0 and 8 and be sure to add a comma between the numbers"
        sleep(2.3)
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