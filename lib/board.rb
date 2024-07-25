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
  def update_possible_moves
    (0...8).each do |row|
      (0...8).each do |col|
        piece = @board[row][col].piece_held
        next if piece.nil?

        piece.possible_moves = piece.valid_moves(@board)
      end
    end
    return
  end

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

    update_possible_moves
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

  def move (start_point, end_point, turn)
    s = find_node(start_point)
    e = find_node(end_point)
    piece = s.piece_held

    if check == true
      @board[e.piece_held.current_possition[0]][e.piece_held.current_possition[1]] = s if e.piece_held
      if check == true
        p "Invalid move, king is still in check"
        return nil
      end

      @board[e.piece_held.current_possition[0]][e.piece_held.current_possition[1]] = e
    end

    if piece.nil?
      p "Invalid move, Empty sqaure selected"
      return nil
    end

    if piece && piece.colour != turn
      p "Invalid move, its #{turn} turn to move"
      return nil
    end

    if !e.piece_held.nil? && s.piece_held.colour == e.piece_held.colour
      p "Invalid move, pieces are of the same colour"
      return nil
    end

    if s.piece_held && s.piece_held.possible_moves.include?(end_point)
      if piece.class.name == "Pawn"
        if pawn_blocked(start_point) != nil || s.piece_held.possible_moves.include?(end_point)
          if e.piece_held != nil && e.piece_held.colour != s.piece_held.colour
            piece_sign = e.piece_held.sign.gsub(/["]/, '')
            @@pieces_taken << piece_sign
          end
          e.assign_piece(piece.class.new(end_point, piece.colour, true))
          @board[start_point[0]][start_point[1]] = Token.new([start_point[0], start_point[1]])
          is_in_check = check == true ?  "king is in check" : ""
          puts is_in_check
        else
          p "Invalid move, pawn blocked"
          return nil
        end
      else
        if e.piece_held != nil && e.piece_held.colour != s.piece_held.colour # move this section of if statement
          piece_sign = e.piece_held.sign.gsub(/["]/, '')
          @@pieces_taken << piece_sign
        end
        e.assign_piece(piece.class.new(end_point, piece.colour))
        @board[start_point[0]][start_point[1]] = Token.new([start_point[0], start_point[1]])
      end

      display_board
      p "Pieces taken so far"
      puts "#{@@pieces_taken.join(' ')}"
      update_possible_moves
      return true
    else
      p "Invalid move"
      return nil
    end
  end

  def pawn_blocked(start_point)
    s = find_node(start_point)

    if s.piece_held != nil && s.piece_held.colour == "Black"
      #black pieces move down so it would be -1 on the index
      infront = find_node([start_point[0]-1, start_point[1]])
      if infront.piece_held.nil?
        return true
      end
    else
      infront = find_node([start_point[0]+1, start_point[1]])
      if infront.piece_held.nil?
        return true
      end
    end
    return nil
  end


  def check
    king_position = []
    (0...8).each do |row|
      (0...8).each do |col|
        king_position = @board[row][col].piece_held if @board[row][col].piece_held.class.name == "King"
      end
    end

    (0...8).each do |row|
      (0...8).each do |col|
        piece = @board[row][col].piece_held
        if piece != nil && piece.colour != king_position.colour && piece.possible_moves.include?(king_position.current_possition)
          return true
        end
      end
    end
  end


end

# need to add check need to add the rules that come with check
# if king is in check dont let any move be made unless it stops him from bheing in check
# dont let king move to any squares where he will be in check


# add chekmate for the program need to fiish game if kings in checkmate

# need to add task logic for pawns, need to put in fucntion of chnaging pieces when hitting opposite sides "base"
