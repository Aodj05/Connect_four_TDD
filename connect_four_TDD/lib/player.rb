# frozen_string_literal: true

require '../lib/game'
require '../lib/board'
require '../lib/player'

class Player

    QUIT = 'q', 'quit', 'exit'

   attr_accessor :board, :name, :piece
   
   def initialize(name = "Justin", board, piece)
       @name = name
       @board = board
       @piece = piece
   end

   def move(column = nil)
       loop do
           column = ask_move
           quit?(column)
           if valid_column?(column)
               if @board.prep_drop(column, @piece)
                   break
               end
           end
       end
   end

   def valid_column?(column)
       (1..7) === column
   end

   def ask_move
       @board.puts("#{@name}#{@piece}, enter a coulumn number to place your piece")
       input = gets.strip
       quit?(input)
       return input.to_i
   end

   def quit?
       quit if QUIT.include?(input)
   end
end

class CPU < Player
    def cpu_move
        return rand(1..7)
    end

    def ask_move
        return eval_board
    end

    def get_move
        super
    end

    def eval_board(piece)
        column_to_try = 1
        until column_to_try == 8
            if @board.column_room?(column_to_try)
                @board.drop_piece(column_to_try, @piece)
                if @board.win?(@piece)
                    @board.remove_piece(column_to_try, @piece)
                    return column_to_try
                else
                    @board.remove_piece(column_to_try, @piece)
                end
            end
            column_to_try += 1
        end
        return rand(1..7)
    end
    def remove_piece(column, piece)
        index = column
        loop do
            if @board[index] == piece
                @board[index] = 'O'
                break
            end
            index += 9
        end
    end
end