require_relative './board'

class Pawn
  attr_accessor :possible_moves, :current_possition, :colour, :has_moved

  def initialize (current, colour, moved = nil)
    @current_possition = current
    @has_moved = moved
    @colour = colour
    @possible_moves = calculate_moves
  end

  def sign
    if @colour != "white"
      return "♙"
    else
      return "♟︎"
    end
  end

  def move_off
    if @colour == "white"
        if @has_moved == nil
          x = [
          [1, 0],[2, 0]
          ]
        else
          x = [
          [1, 0]
          ]
        end
    end

    if @colour == "Black"
      if @has_moved == nil
        x = [
        [-1, 0],[-2, 0]
        ]
      else
        x = [
        [-1, 0]
        ]
      end
    end
    x
  end

  def calculate_moves
    possible_moves = []
    row, col = @current_possition

    # Possible pawn moves offsets
    move_offsets = move_off

    # Calculate and filter valid moves
    move_offsets.each do |(dr, dc)|
      new_row, new_col = row + dr, col + dc
      if new_row.between?(0, 7) && new_col.between?(0, 7)
        #need to check if the possible move is a legal move
        #before adding it to the variable
        possible_moves << [new_row, new_col]
      end
    end
    possible_moves
  end

  def valid_moves(board)
    @possible_moves.select do |move|
      row, col = move
      board[row][col].piece_held.nil? || board[row][col].piece_held.colour != @colour
    end

    if @colour == "white"
      row, col = [1, 0]
      # Check diagonal captures for white pawn (moving up the board)
      if row + 1 < 8
        if col + 1 < 8 && board[row][col + 1] && board[row][col + 1].piece_held && board[row][col + 1].piece_held.colour != @colour
          possible_moves << [row, col + 1]
        end

        if col - 1 >= 0 && board[row ][col - 1] && board[row ][col - 1].piece_held && board[row ][col - 1].piece_held.colour != @colour
          possible_moves << [row, col - 1]
        end
      end
    else
      # Check diagonal captures for black pawn (moving down the board)
      row, col = [-1, 0]
      if row - 1 >= 0
        if col + 1 < 8 && board[row][col + 1] && board[row][col + 1].piece_held && board[row][col + 1].piece_held.colour != @colour
          possible_moves << [row, col + 1]
        end

        if col - 1 >= 0 && board[row][col - 1] && board[row][col - 1].piece_held && board[row][col - 1].piece_held.colour != @colour
          possible_moves << [row, col - 1]
        end
      end
    end
    return @possible_moves
  end
end

class Knight
  attr_accessor :possible_moves, :current_possition, :colour

  def initialize (current, colour)
    @current_possition = current
    @possible_moves = calculate_moves
    @colour = colour
  end

  def sign
    if @colour == "white"
      return "♞"
    else
      return "♘"
    end
  end
  def move_off
    x = [
      [-2, -1], [-2, 1], [2, -1], [2, 1],
      [-1, -2], [-1, 2], [1, -2], [1, 2]
    ]
    x
  end
  def calculate_moves
    possible_moves = []
    row, col = @current_possition

    # Possible knight moves offsets
    move_offsets = move_off

    # Calculate and filter valid moves
    move_offsets.each do |(dr, dc)|
      new_row, new_col = row + dr, col + dc
      if new_row.between?(0, 7) && new_col.between?(0, 7)
        possible_moves << [new_row, new_col]
      end
    end
    possible_moves
  end

  def valid_moves(board)
    @possible_moves.select do |move|
      row, col = move
      board[row][col].piece_held.nil? || board[row][col].piece_held.colour != @colour
    end
  end
end

class Bishop
  attr_accessor :possible_moves, :current_possition, :colour

  def initialize (current, colour)
    @current_possition = current
    @possible_moves = calculate_moves
    @colour = colour
  end

  def sign
    if @colour != "white"
      return "♗"
    else
      return "♝"
    end
  end
  def move_off
    directions = [[-1, -1], [-1, 1], [1, -1], [1, 1]]
    directions
  end
  def calculate_moves
    possible_moves = []
    row, col = @current_possition

    # Diagonal moves: top-left, top-right, bottom-left, bottom-right
    directions = move_off

    directions.each do |(dr, dc)|
      new_row, new_col = row + dr, col + dc

      while new_row.between?(0, 7) && new_col.between?(0, 7)
        possible_moves << [new_row, new_col]
        new_row += dr
        new_col += dc
      end
    end

    possible_moves
  end

  def valid_moves(board)
    valid_moves = []
    directions = [[1, 1], [1, -1], [-1, 1], [-1, -1]]

    directions.each do |dr, dc|
      (1..7).each do |i|
        new_row, new_col = @current_possition[0] + i * dr, @current_possition[1] + i * dc
        break unless new_row.between?(0, 7) && new_col.between?(0, 7)

        if board[new_row][new_col].piece_held.nil?
          valid_moves << [new_row, new_col]
        elsif board[new_row][new_col].piece_held
          valid_moves << [new_row, new_col]
          break
        else
          break
        end
      end
    end
    valid_moves
  end
end

class Rook
  attr_accessor :possible_moves, :current_possition, :colour

  def initialize (current, colour)
    @current_possition = current
    @possible_moves = calculate_moves
    @colour = colour
  end

  def sign
    if @colour != "white"
      return "♖"
    else
      return "♜"
    end
  end

  def move_off
    directions = [[-1, 0], [1, 0], [0, -1], [0, 1]]
    directions
  end

  def calculate_moves
    possible_moves = []
    row, col = @current_possition

    # Horizontal and vertical directions
    directions =move_off

    directions.each do |(dr, dc)|
      new_row, new_col = row + dr, col + dc

      while new_row.between?(0, 7) && new_col.between?(0, 7)
        possible_moves << [new_row, new_col]
        new_row += dr
        new_col += dc
      end
    end

    possible_moves
  end
  def valid_moves(board)
    valid_moves = []
    directions = [[-1, 0], [1, 0], [0, -1], [0, 1]]

    directions.each do |dr, dc|
      (1..7).each do |i|
        new_row, new_col = @current_possition[0] + i * dr, @current_possition[1] + i * dc
        break unless new_row.between?(0, 7) && new_col.between?(0, 7)

        if board[new_row][new_col].piece_held.nil?
          valid_moves << [new_row, new_col]
        elsif board[new_row][new_col].piece_held && board[new_row][new_col].piece_held.colour != @colour
          valid_moves << [new_row, new_col]
          break
        else
          break
        end
      end
    end

    valid_moves
  end
end

class Queen
  attr_accessor :possible_moves, :current_possition, :colour

  def initialize (current, colour)
    @current_possition = current
    @possible_moves = calculate_moves
    @colour = colour
  end

  def sign
    if @colour != "white"
      return "♕"
    else
      return "♛"
    end
  end

  def move_off
    directions = [
      [-1, 0], [1, 0], [0, -1], [0, 1],  # Rook-like moves
      [-1, -1], [-1, 1], [1, -1], [1, 1]  # Bishop-like moves
    ]
    directions
  end

  def calculate_moves
    possible_moves = []
    row, col = @current_possition

    # Queen moves: combines rook and bishop moves
    directions = move_off

    directions.each do |(dr, dc)|
      new_row, new_col = row + dr, col + dc

      while new_row.between?(0, 7) && new_col.between?(0, 7)
        possible_moves << [new_row, new_col]
        new_row += dr
        new_col += dc
      end
    end

    possible_moves
  end

  def valid_moves(board)
    valid_moves = []
    directions = [
      [-1, 0], [1, 0], [0, -1], [0, 1],  # Rook-like moves
      [-1, -1], [-1, 1], [1, -1], [1, 1]  # Bishop-like moves
    ]

    directions.each do |dr, dc|
      (1..7).each do |i|
        new_row, new_col = @current_possition[0] + i * dr, @current_possition[1] + i * dc
        break unless new_row.between?(0, 7) && new_col.between?(0, 7)

        if board[new_row][new_col].piece_held.nil?
          valid_moves << [new_row, new_col]
        elsif board[new_row][new_col].piece_held && board[new_row][new_col].piece_held.colour != @colour
          valid_moves << [new_row, new_col]
          break
        else
          break
        end
      end
    end

    valid_moves
  end
end

class King
  attr_accessor :possible_moves, :current_possition, :colour

  def initialize (current, colour)
    @current_possition = current
    @possible_moves = calculate_moves
    @colour = colour
  end

  def sign
    if @colour != "white"
      return "♔"
    else
      return "♚"
    end
  end

  def move_off
    move_offsets = [
      [-1, -1], [-1, 0], [-1, 1],
      [0, -1],         [0, 1],
      [1, -1], [1, 0], [1, 1]
    ]
    move_offsets
  end

  def calculate_moves
    possible_moves = []
    row, col = @current_possition

    # King moves: one square in any direction
    directions = move_off

    directions.each do |(dr, dc)|
      new_row, new_col = row + dr, col + dc

      if new_row.between?(0, 7) && new_col.between?(0, 7)
        possible_moves << [new_row, new_col]
      end
    end
    possible_moves
  end

  def valid_moves(board)
    @possible_moves = []
    directions = [
      [-1, -1], [-1, 0], [-1, 1],
      [0, -1],         [0, 1],
      [1, -1], [1, 0], [1, 1]
    ]

    directions.each do |dr, dc|
      new_row, new_col = @current_possition[0] + dr, @current_possition[1] + dc
      if new_row.between?(0, 7) && new_col.between?(0, 7)
        if board[new_row][new_col].nil? || board[new_row][new_col].piece_held.nil?
          @possible_moves << [new_row, new_col]
        elsif board[new_row][new_col].piece_held.colour != @colour
          @possible_moves << [new_row, new_col]
        end
      end
    end
    position_in_check(board)
  end

  def position_in_check(board)
      (0...8).each do |row|
        (0...8).each do |col|
          @possible_moves.each do |move|
          piece = board[row][col].piece_held
          if piece && piece.possible_moves != nil &&piece.possible_moves.include?(move) && piece.colour != @colour
            @possible_moves.delete(move)
          end
        end
      end
    end

    if @possible_moves.empty? == true
      return nil
    end
    @possible_moves
  end
end
