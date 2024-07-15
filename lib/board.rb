require_relative './pieces'

class Token
  attr_reader :value, :piece_held

  def initialize (value, piece = nil)
    @value = value
    @piece_held = piece
  end

  def assign_piece(name)
    @piece_held = name
  end
end

class Board
  attr_accessor :board

  def initialize
    @board = create_board
  end

  #creates an 8 * 8 board of object tokens, while giving them a value which is a cooridnate
  def create_board
    grid = Array.new(8) { Array.new(8) }
    (0...8).each do |row|
      (0...8).each do |col|
        grid[row][col] = Token.new([row, col])
      end
    end
    grid
  end

  def find_node(value)
    (0...8).each do |row|
      (0...8).each do |col|
        return @board[row][col] if @board[row][col].value == value
      end
    end
    nil # Return nil if the node is not found
  end

  def populate_board
    #for white pieces
    #adding knights to the board
    find_node([7, 1]).assign_piece("K")
    find_node([7, 6]).assign_piece("K")

    #adding rooks to the board
    find_node([0, 0]).assign_piece("R")
    find_node([0, 7]).assign_piece("R")

    #adding pawns to the board
    (0...8).each do |index|
      find_node([1, index]).assign_piece("P")
    end

    #adding bishops to the board
    find_node([7, 2]).assign_piece("B")
    find_node([7, 5]).assign_piece("B")

    #adding queens to the board
    find_node([7, 3]).assign_piece("Q")

    #adding kings to the board
    find_node([7, 4]).assign_piece("KN")


    #for black pieces
    #adding knights to the board
    find_node([0, 1]).assign_piece("K")
    find_node([0, 6]).assign_piece("K")

    #adding rooks to the board
    find_node([7, 0]).assign_piece("R")
    find_node([7, 7]).assign_piece("R")

    #adding pawns to the board
    (0...8).each do |index|
      find_node([6, index]).assign_piece("P")
    end
    #adding bishops to the board
    find_node([0, 2]).assign_piece("B")
    find_node([0, 5]).assign_piece("B")

    #adding queens to the board
    find_node([0, 3]).assign_piece("Q")

    #adding kings to the board
    find_node([0, 4]).assign_piece("KN")
  end

  def display_board
    populate_board
    puts "  a b c d e f g h"
    @board.each_with_index do |row, i|
      print "#{8 - i} "
      row.each do |cell|
        piece = cell.piece_held.nil? ? "🩦" : cell.piece_held
        print "#{piece} "
      end
      puts "#{8 - i}"
    end
    puts "  a b c d e f g h"
  end
end
