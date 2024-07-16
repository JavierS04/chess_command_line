require_relative './board'

class Pawn
  attr_accessor :possible_moves, :current_possition, :colour, :has_moved

  def initialize (current, colour, moved = nil)
    @current_possition = current
    @possible_moves = calculate_moves
    @colour = colour
    @has_moved = moved
  end

  def sign
    if @colour == "white"
      return "♟︎"
    else
      return "♙"
    end
  end

  def calculate_moves
    possible_moves = []
    row, col = @current_possition

    # Possible pawn moves offsets
    if @has_moved == nil
      move_offsets = [
      [0, 1],[0, 2]
      ]
    else
      move_offsets = [
      [0, 1]
      ]
    end

    # Calculate and filter valid moves
    move_offsets.each do |(dr, dc)|
      new_row, new_col = row + dr, col + dc
      if new_row.between?(0, 7) && new_col.between?(0, 7)
        possible_moves << [new_row, new_col]
      end
    end
    possible_moves
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
      return "♘"
    else
      return "♞"
    end
  end

  def calculate_moves
    possible_moves = []
    row, col = @current_possition

    # Possible knight moves offsets
    move_offsets = [
      [-2, -1], [-2, 1], [2, -1], [2, 1],
      [-1, -2], [-1, 2], [1, -2], [1, 2]
    ]



    # Calculate and filter valid moves
    move_offsets.each do |(dr, dc)|
      new_row, new_col = row + dr, col + dc
      if new_row.between?(0, 7) && new_col.between?(0, 7)
        possible_moves << [new_row, new_col]
      end
    end
    possible_moves
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
    if @colour == "white"
      return "♗"
    else
      return "♝"
    end
  end

  def calculate_moves
    possible_moves = []
    row, col = @current_possition

    # Diagonal moves: top-left, top-right, bottom-left, bottom-right
    directions = [[-1, -1], [-1, 1], [1, -1], [1, 1]]

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
end

class Rook
  attr_accessor :possible_moves, :current_possition, :colour

  def initialize (current, colour)
    @current_possition = current
    @possible_moves = possible_moves
    @colour = colour
  end

  def sign
    if @colour == "white"
      return "♖"
    else
      return "♜"
    end
  end

  def calculate_moves
    possible_moves = []
    row, col = @current_possition

    # Horizontal and vertical directions
    directions = [[-1, 0], [1, 0], [0, -1], [0, 1]]

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
end

class Queen
  attr_accessor :possible_moves, :current_possition, :colour

  def initialize (current, colour)
    @current_possition = current
    @possible_moves = calculate_moves
    @colour = colour
  end

  def sign
    if @colour == "white"
      return "♕"
    else
      return "♛"
    end
  end

  def calculate_moves
    possible_moves = []
    row, col = @current_possition

    # Queen moves: combines rook and bishop moves
    directions = [
      [-1, 0], [1, 0], [0, -1], [0, 1],  # Rook-like moves
      [-1, -1], [-1, 1], [1, -1], [1, 1]  # Bishop-like moves
    ]

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

end

class King
  attr_accessor :possible_moves, :current_possition, :colour

  def initialize (current, colour)
    @current_possition = current
    @possible_moves = calculate_moves
    @colour = colour
  end

  def sign
    if @colour == "white"
      return "♔"
    else
      return "♚"
    end
  end

  def calculate_moves
    possible_moves = []
    row, col = @current_possition

    # King moves: one square in any direction
    move_offsets = [
      [-1, -1], [-1, 0], [-1, 1],
      [0, -1],         [0, 1],
      [1, -1], [1, 0], [1, 1]
    ]

    move_offsets.each do |(dr, dc)|
      new_row, new_col = row + dr, col + dc
      if new_row.between?(0, 7) && new_col.between?(0, 7)
        possible_moves << [new_row, new_col]
      end
    end

    possible_moves
  end
end
