class Pawn
  attr_accessor :possible_moves, :current_possition, :colour

  def initialize (current, possible_moves = nil, colour)
    @current_possition = current
    @possible_moves = possible_moves
    @colour = colour
  end
end

class Knight
  attr_accessor :possible_moves, :current_possition, :colour

  def initialize (current, possible_moves = nil, colour)
    @current_possition = current
    @possible_moves = possible_moves
    @colour = colour
  end
end

class Bishop
  attr_accessor :possible_moves, :current_possition, :colour

  def initialize (current, possible_moves = nil, colour)
    @current_possition = current
    @possible_moves = possible_moves
    @colour = colour
  end
end

class Rook
  attr_accessor :possible_moves, :current_possition, :colour

  def initialize (current, possible_moves = nil, colour)
    @current_possition = current
    @possible_moves = possible_moves
    @colour = colour
  end
end

class Queen
  attr_accessor :possible_moves, :current_possition, :colour

  def initialize (current, possible_moves = nil, colour)
    @current_possition = current
    @possible_moves = possible_moves
    @colour = colour
  end
end

class King
  attr_accessor :possible_moves, :current_possition, :colour

  def initialize (current, possible_moves = nil, colour)
    @current_possition = current
    @possible_moves = possible_moves
    @colour = colour
  end
end
