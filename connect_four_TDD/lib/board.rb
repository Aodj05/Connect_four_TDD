# frozen_string_literal: true

require '../lib/game'
require '../lib/player'
require '../lib/board'

class Board
    attr_accessor :board

    def initialize(board = nil)
        @board = default if board == nil
    end

    def default

		return [
						 "-", "O", "O", "O", "O", "O", "O", "O", "-",
	 				   "-", "O", "O", "O", "O", "O", "O", "O", "-",
	 				   "-", "O", "O", "O", "O", "O", "O", "O", "-",
	 				   "-", "O", "O", "O", "O", "O", "O", "O", "-",
	 				   "-", "O", "O", "O", "O", "O", "O", "O", "-",
	 				   "-", "O", "O", "O", "O", "O", "O", "O", "-"
                      ]
    end
    
    def board_string_col
        board_col_arr = []
        @board.each_with_index do |e, i|
            if (1..7) === i
                board_col_arr << '-'
                until i > 52
                    board_col_arr << @board[i]
                    i += 9
                end
            end
        end
        return board_col_arr.join
    end

    def board_string_row
        return @board.join
    end

    def board_string_diag
        board_dia_arr = []
        @board.each_with_index do |e, i|
            if (1..3) === i || i == 10 || i == 19
                board_dia_arr << proc_dia(i, 'right')
            elsif (5..7) === i || i == 16 || i == 25
                board_dia_arr << proc_dia(i, 'left')
            elsif i == 4
                board_dia_arr << proc_dia(i, 'right')
                board_dia_arr << proc_dia(i, 'left')
            end
        end
        return board_dia_arr.join('-')
    end

    def proc_dia
        arr = []
        until @board[index] == nil || @board[index] == ']' || @board[index] == '[' || @board[index] == '-' || @board[index].is_a?(Fixnum)
            arr << @board[index]
            direction == 'right' ? index += 10 : index += 8
        end
        return arr.join
    end
   
   def render
    puts ""
       @board.each_with_index do |row, index|
        if index % 9 == 0 && index != 0
            puts ""
            print row
        else
            print row
        end
    end
    puts ""
    print "-1234567-"
    puts ""
   end

   def message(message)
    puts ""
    puts message
    puts ""
   end

   def win?(piece)
    return true if four_in_a_row(piece)
    return true if four_in_a_column(piece)
    return true if four_diagonal(piece)
   end

   def piece_string(piece)
       return piece.to_s * 4
   end

   def four_in_a_row(piece)
    return true if board_string_row.include?(piece_string(piece))
   end

   def four_in_a_column(piece)
    return true if board_string_col.include?(piece_string(piece))
   end

   def column_string(index) 
    board_index = index - 18
    arr = []
    6.times do
        arr << @board[board_index]
        board_index += 9
    end
    return arr.join
   end

   def four_diagonal(piece)
    return true if board_string_diag.include?(piece_string(piece))
   end

   def draw?
    @board.any? { |x| x == 'O' } ? false : true
   end

   def column_room?(column)
    @board[column] == 'O' ? true : false
   end

   def prep_drop(column, piece)
    if column_room?(column)
        drop_piece(column, piece)
        true
    else
        draw?
        false
    end
   end

   def drop_piece(column, piece)
    index = (column + 45)
    loop do
        if @board[index] == 'O'
            @board[index] = piece
            break
        end
        index -= 9
    end
   end

   def remove(column, piece)
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
