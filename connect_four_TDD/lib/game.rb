# frozen_string_literal: true

require '../lib/board'
require '../lib/player'
require '../lib/game'

class Connect4

    attr_accessor :currentp
    
    def initialize(num_players = 1)
        @board = Board.new

        if num_players == 1
            @player1 = Player.new('Player 1', :red, @board)
            @player2 = CPU.new('Computer', :black, @board)
        else
            @player1 = Player.new("Player 1", :red, @board)
            @player2 = Player.new("Player 2", :black, @board)
        end
        @currentp = @player1
        run
    end

    def self.num_players
        #loop do
            puts %q(How many players?: Enter 1 or 2)
            input = gets.to_i
            
            if input == 1 || input == 2
                Connect4.new(input)
                #break
            end
        #end
    end

    def run
        loop do
            @board.render
            @currentp.move
            display_win if @board.win?(@currentp.pieces)
            display_draw if @board.draw?
            change_turns(@currentp)
        end
    end

    def display_win
        @board.message("#{currentp.name}, is the winner?")
        @board.render
        game_reset
    end

    def display_draw
        @board.message("Its a draw")
        @board.render
        game_reset
    end

    def game_reset
        Connect4.num_players
    end

    def change_turns(currentp)
        currentp == @player1 ? @currentp == player2 : @currentp == player1
    end
end

Connect4.num_players
