require_relative './pieces'
require_relative './knight_travails'

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
  @@pieces_taken = []
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
    find_node([7, 1]).assign_piece(Knight.new([7,1], "Black"))
    find_node([7, 6]).assign_piece(Knight.new([7,6], "Black"))

    #adding rooks to the board
    find_node([7, 0]).assign_piece(Rook.new([7,0], "Black"))
    find_node([7, 7]).assign_piece(Rook.new([7,0], "Black"))

    #adding pawns to the board
    (0...8).each do |index|
      find_node([6, index]).assign_piece(Pawn.new([6,index], "Black"))
    end

    #adding bishops to the board
    find_node([7, 2]).assign_piece(Bishop.new([7,2], "Black"))
    find_node([7, 5]).assign_piece(Bishop.new([7,5], "Black"))

    #adding queens to the board
    find_node([7, 3]).assign_piece(Queen.new([7,3], "Black"))

    #adding kings to the board
    find_node([7, 4]).assign_piece(King.new([7,4], "Black"))


    #for black pieces
    #adding knights to the board
    find_node([0, 1]).assign_piece(Knight.new([0,1], "white"))
    find_node([0, 6]).assign_piece(Knight.new([0,6], "white"))

    #adding rooks to the board
    find_node([0, 0]).assign_piece(Rook.new([0,0], "white"))
    find_node([0, 7]).assign_piece(Rook.new([0,7], "white"))

    #adding pawns to the board
    (0...8).each do |index|
      find_node([1, index]).assign_piece(Pawn.new([1,index], "white"))
    end
    #adding bishops to the board
    find_node([0, 2]).assign_piece(Bishop.new([0,2], "white"))
    find_node([0, 5]).assign_piece(Bishop.new([0,5], "white"))

    #adding queens to the board
    find_node([0, 3]).assign_piece(Queen.new([0,3], "white"))

    #adding kings to the board
    find_node([0, 4]).assign_piece(King.new([0,4], "white"))
  end

  def start_game
    populate_board
    display_board
  end

  def display_board
    #puts "  a b c d e f g h"
    @board.reverse.each_with_index do |row, i|
      print "#{8 - i} "  # Show row numbers from 8 to 1
      row.each do |cell|
        piece = cell.piece_held.nil? ? "🩦" : cell.piece_held.sign
        print "#{piece} "
      end
      puts
    end
    puts "  a b c d e f g h"
  end

  def move (start_point, end_point)
    s = find_node(start_point)
    e = find_node(end_point)
    piece = s.piece_held

    if s.piece_held && s.piece_held.possible_moves.include?(end_point) && legal_move(start_point, end_point, piece)
      if e.piece_held != nil && e.piece_held.colour != s.piece_held.colour
        piece_sign = e.piece_held.sign.gsub(/["]/, '')
        @@pieces_taken << piece_sign
      end

      if piece.class.name == "Pawn"
        e.assign_piece(piece.class.new(end_point, piece.colour, true))
      else
        e.assign_piece(piece.class.new(end_point, piece.colour))
      end
      @board[start_point[0]][start_point[1]] = Token.new([start_point[0], start_point[1]])

      display_board
      p "Pieces taken so far"
      puts "#{@@pieces_taken.join(' ')}"
    else
      p "Invalid move"
    end
  end

  def legal_move(start_point, end_poinnt, piece)
    # using the methods in knights travails to see if the optimal path from one space to another, which only uses the available possible move, returns an array of how to move from current to target square and then checks if there is any pieces on those squares
    # need to change it slightly so it allows take to take place
    # that shouldn't be to difficult hopefully :)
    b = Board_knight.new(piece.move_off)

    moves = b.start_search(start_point, end_poinnt, piece.move_off)
    x = moves.shift # first coordinate is the start so need to remove that from the array
    x = moves.pop
    while !moves.empty?
      check = moves.shift

      if find_node(check).piece_held
        return nil
      end
    end
    return true
  end
end


# need to add alternating rounds so white then black then white and so fourth




# need to add check and chekmate for the program
