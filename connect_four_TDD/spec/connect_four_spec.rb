# frozen_string_literal: true

require '../lib/game'
require '../lib/board'
require '../lib/player'

describe Board do
    let( :board ) { Board.new }
    let( :piece ) { :black }

    describe '#initialize' do
        it 'checks if the board is created' do
            default = [
                "-", "O", "O", "O", "O", "O", "O", "O", "-",
               "-", "O", "O", "O", "O", "O", "O", "O", "-",
               "-", "O", "O", "O", "O", "O", "O", "O", "-",
               "-", "O", "O", "O", "O", "O", "O", "O", "-",
               "-", "O", "O", "O", "O", "O", "O", "O", "-",
               "-", "O", "O", "O", "O", "O", "O", "O", "-"
             ]
            expect(board.board).to eq(default)
        end
    end

    describe '#board_string_col' do
        it 'should create all columns as one string' do
            column_str = '-OOOOOO-OOOOOO-OOOOOO-OOOOOO-OOOOOO-OOOOOO-OOOOOO'
            expect(board.board_string_col).to eq(column_str)
        end
    end

    describe '#win?' do
        it 'should return true if there is a winning column' do
            board.board = [
                "-", "O", "O", "O", "O", "O", "O", "O", "-",
                "-", "O", "O", "O", "O", "O", "O", "O", "-",
                "-", "black", "O", "O", "O", "O", "O", "O", "-",
                "-", "black", "black", "O", "O", "O", "O", "O", "-",
                "-", "black", "O", "O", "O", "O", "O", "O", "-",
                "-", "black", "black", "O", "O", "O", "O", "O", "-"
            ]
            expect(board.win?(piece)).to be(true)
        end
        it 'should return true if there is a winning row' do
            board.board = [
                "-", "O", "O", "O", "O", "O", "O", "O", "-",
                "-", "O", "O", "O", "O", "O", "O", "O", "-",
                "-", "O", "O", "O", "O", "O", "O", "O", "-",
                "-", "O", "O", "O", "O", "O", "O", "O", "-",
                "-", "O", "O", "O", "O", "O", "O", "O", "-",
                "-", "O", "O", "O", "black", "black", "black", "black", "-"
            ]
            expect(board.win?(piece)).to be(true)
        end
        it 'should return true if there is a winning diagonal' do
            board.board = [
                "-", "O", "O", "O", "O", "O", "O", "O", "-",
                "-", "O", "O", "O", "O", "O", "O", "O", "-",
                "-", "O", "O", "O", "black", "O", "O", "O", "-",
                "-", "O", "O", "O", "black", "black", "O", "O", "-",
                "-", "O", "O", "O", "black", "black", "black", "O", "-",
                "-", "O", "O", "O", "black", "black", "black", "black", "-"
            ]
            expect(board.win?(piece)).to be(true)
        end
        it 'should return false if there is no winner' do
            expect(board.win?(piece)).to be(false)
        end
    end

    describe '#four_in_a_row' do
        it 'should return true if theres a row of 4' do
            board.board = [
                "-", "O", "O", "O", "O", "O", "O", "O", "-",
                "-", "O", "O", "O", "O", "O", "O", "O", "-",
                "-", "O", "O", "O", "O", "O", "O", "O", "-",
                "-", "O", "O", "O", "O", "O", "O", "O", "-",
                "-", "O", "O", "O", "O", "O", "O", "O", "-",
                "-", "O", "O", "black", "black", "black", "black", "O", "-"
            ]
            expect(board.four_in_a_row(piece)).to be(true)
        end
    end

    describe '#four_in_a_column'do
        it 'should detect a column of 4' do
            board.board = [
                "-", "O", "O", "O", "O", "O", "O", "O", "-",
                "-", "O", "O", "O", "O", "O", "O", "O", "-",
                "-", "O", "O", "O", "O", "O", "O", "black", "-",
                "-", "O", "O", "O", "O", "O", "O", "black", "-",
                "-", "O", "O", "O", "O", "O", "O", "black", "-",
                "-", "O", "O", "O", "O", "O", "O", "black", "-"
            ]
            expect(board.four_in_a_column(piece)).to be(true)
        end
    end

    describe '#four_diagonal' do
        it 'should return true if four in a diagnal' do
            board.board =  [
                "-", "O", "O", "O", "O", "O", "O", "O", "-",
                "-", "O", "O", "O", "O", "O", "O", "O", "-",
                "-", "O", "O", "O", "black", "O", "O", "O", "-",
                "-", "O", "O", "O", "red", "black", "O", "red", "-",
                "-", "O", "O", "O", "black", "black", "black", "red", "-",
                "-", "O", "O", "O", "red", "red", "black", "black", "-"
            ]
            expect(board.four_diagonal(piece)).to be(true)
        end
    end

    describe '#draw?' do
        it 'returns true if all positions are filled with no winner' do
            board.board = [
                "-", "red", "red", "red", "black", "red", "red", "black", "-",
                "-", "red", "black", "red", "red", "black", "black", "red", "-",
                "-", "black", "black", "red", "red", "red", "black", "red", "-",
                "-", "red", "red", "black", "red", "red", "black", "red", "-",
                "-", "red", "black", "red", "black", "red", "red", "black", "-",
                "-", "black", "red", "red", "black", "black", "black", "red", "-"
            ]
            expect(board.draw?).to be(true)
        end
        it 'returns false if there are still positions open' do
            board.board = [
                "-", "O", "O", "red", "black", "O", "red", "O", "-",
                "-", "red", "black", "red", "red", "black", "black", "red", "-",
                "-", "black", "black", "red", "red", "red", "black", "red", "-",
                "-", "red", "red", "black", "red", "red", "black", "red", "-",
                "-", "red", "black", "red", "black", "red", "red", "black", "-",
                "-", "black", "red", "red", "black", "black", "black", "red", "-"
            ]
            expect(board.draw?).to be(false)
        end
    end

    describe '#column_room?' do
        it 'should return true if a column has an empty space' do
            expect(board.column_room?(1)).to be(true)
        end
        it 'should return false if the top row contains red or black' do
            board.board = [
                "-", "O", "red", "red", "black", "red", "red", "black", "-",
                "-", "red", "black", "red", "red", "black", "black", "red", "-",
                "-", "black", "black", "red", "red", "red", "black", "red", "-",
                "-", "red", "red", "black", "red", "red", "black", "red", "-",
                "-", "red", "black", "red", "black", "red", "red", "black", "-",
                "-", "black", "red", "red", "black", "black", "black", "red", "-"
            ]
            expect(board.column_room?(2)).to be(false)
        end
    end

    describe '#drop_piece' do
        it ' should put the piece in a selected position' do
            board.drop_piece(1, piece)
            dropped_piece = [
                "-", "O", "O", "O", "O", "O", "O", "O", "-",
                "-", "O", "O", "O", "O", "O", "O", "O", "-",
                "-", "O", "O", "O", "O", "O", "O", "O", "-",
                "-", "O", "O", "O", "O", "O", "O", "O", "-",
                "-", "O", "O", "O", "O", "O", "O", "O", "-",
                "-", ":black", "O", "O", "O", "O", "O", "O", "-"
            ]
            expect(board.board).to eq(dropped_piece)
        end
    end

    describe '#remove(column, piece)' do
        it 'should remove a piece at the selected position' do
            board.board = [
                "-", "O", "O", "O", "O", "O", "O", "O", "-",
                "-", "O", "O", "O", "O", "O", "O", "O", "-",
                "-", "O", "O", "O", "O", "O", "O", "O", "-",
                "-", "O", "O", "O", "O", "O", "O", "O", "-",
                "-", "O", "O", "O", "O", "O", "O", "O", "-",
                "-", "O", "O", "O", "O", "O", "O", ":black", "-"
            ]
            board.remove(7, :black)
            removed_piece = [
                "-", "O", "O", "O", "O", "O", "O", "O", "-",
                "-", "O", "O", "O", "O", "O", "O", "O", "-",
                "-", "O", "O", "O", "O", "O", "O", "O", "-",
                "-", "O", "O", "O", "O", "O", "O", "O", "-",
                "-", "O", "O", "O", "O", "O", "O", "O", "-",
                "-", "O", "O", "O", "O", "O", "O", "O", "-"
            ]
            expect(board.board).to eq(removed_piece)
        end
    end
end

describe Player do
    let(:board) { Board.new }
    let(:piece) {:red }
    let(:player) { Player.new('Player 1', piece, board) }

    describe '#initialize' do
        it 'should create an instance of player' do
            player1 = player
            expect(player1).to be_an_instance_of(Player)
        end
        it 'should accept only three arguments' do
            expect{ Player.new('Jack', red, black, Board.new) }.to raise_error(ArgumentError)
        end
        it 'should initialize the name' do
            expect(player.name).to eq('Player 1')
        end
        it 'should initialize board' do
            expect(player.piece).to eq(board)
        end
        it 'should initialize piece' do
            expect(player.board).to eq(piece)
        end
    end

    describe '#valid_column?' do
        it 'should return true if correct position input(1-7)' do
            expect(player.valid_column?(1)).to be(true)
        end
        it 'should return false if incorrect position input' do
            expect(player.valid_column?(8)).to be(false)
        end
        it 'should return false if nothing id inputted' do
            expect(player.valid_column?('')).to be(false)
        end
    end

    describe '#ask_move' do
        it 'should return input as integer' do
            allow(player).to receive(:gets).and_return('4')
            expect(player.ask_move).to eq(4)
        end
    end
end

describe CPU do
    let(:board) { Board.new }
    let(:cpu) { CPU.new('cpu', :black, board) }

    describe '#eval_board' do
        it 'should return a random number if to #win?' do
            pos = cpu.eval_board
            expect(pos).to eq(Fixnum)
        end
        it 'should select winning row position if available' do
            @board = [
                "-", "O", "O", "O", "O", "O", "O", "O", "-",
                "-", "O", "O", "O", "O", "O", "O", "O", "-",
                "-", "O", "O", "O", "O", "O", "O", "O", "-",
                "-", "O", "O", "O", "O", "O", "O", "O", "-",
                "-", "O", "O", "O", "O", "O", "O", "O", "-",
                "-", ":black", ":black", ":black", "O", ":black", "O", "O", "-"
            ]
            pos = cpu.eval_board
            expect(pos).to eq(3)
        end
    end
end

describe Connect4 do
    let(:connect4) { Connect4.new }

    describe '#num_players' do
        it 'should recieve amount of players and return a value' do
            allow(Connect4).to receive(:num_players).and_return(2)
            expect(Connect4.num_players).to eq(2)
        end
    end

    describe '#initialize' do
        it 'should create board object' do
            game = Connect4.new(1)
            board = game.instance_variable_get(:@board)
            expect(game.instance_variable_get(:@board)).to eq(board)
        end
        it 'should create cpu' do
            game = Connect4.new(1)
            board = game.instance_variable_get(:@player2)
            expect(game.instance_variable_get(:@player2)).to eq(cpu)
        end
        it 'should create currentP' do
            Connect4.new
            expect(@currentP).to eq(player1)
        end
    end

    describe '#change_turns' do
        it 'should change the players turns' do
            Connect4.new(1)
            @currentP = player2
            connect4.change_turns(@currentP)
            expect(currentP).to eq(player1)
        end
    end
end