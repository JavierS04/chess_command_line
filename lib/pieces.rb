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
    move_offsets = move_off

    move_offsets.each do |(dr, dc)|
      new_row, new_col = row + dr, col + dc
      if new_row.between?(0, 7) && new_col.between?(0, 7)
        possible_moves << [new_row, new_col]
      end
    end

    possible_moves
  end
end
