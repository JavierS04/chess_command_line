class Pawn
  attr_accessor :possible_moves, :current_possition, :colour

  def initialize (current, colour, possible_moves = nil)
    @current_possition = current
    @possible_moves = possible_moves
    @colour = colour
  end

  def sign
    if @colour == "white"
      return "♟︎"
    else
      return "♙"
    end
  end
end

class Knight
  attr_accessor :possible_moves, :current_possition, :colour

  def initialize (current, colour, possible_moves = nil)
    @current_possition = current
    @possible_moves = possible_moves
    @colour = colour
  end

  def sign
    if @colour == "white"
      return "♘"
    else
      return "♞"
    end
  end
end

class Bishop
  attr_accessor :possible_moves, :current_possition, :colour

  def initialize (current, colour, possible_moves = nil)
    @current_possition = current
    @possible_moves = possible_moves
    @colour = colour
  end

  def sign
    if @colour == "white"
      return "♗"
    else
      return "♝"
    end
  end
end

class Rook
  attr_accessor :possible_moves, :current_possition, :colour

  def initialize (current, colour, possible_moves = nil)
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
end

class Queen
  attr_accessor :possible_moves, :current_possition, :colour

  def initialize (current, colour, possible_moves = nil)
    @current_possition = current
    @possible_moves = possible_moves
    @colour = colour
  end

  def sign
    if @colour == "white"
      return "♕"
    else
      return "♛"
    end
  end
end

class King
  attr_accessor :possible_moves, :current_possition, :colour

  def initialize (current, colour, possible_moves = nil)
    @current_possition = current
    @possible_moves = possible_moves
    @colour = colour
  end

  def sign
    if @colour == "white"
      return "♔"
    else
      return "♚"
    end
  end
end
