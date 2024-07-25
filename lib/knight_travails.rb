require_relative './pieces'

class Node
    attr_accessor :value, :possible_moves

    def initialize(value, moves)
        @value = value
        @possible_moves = calculate_moves(moves)
    end

    def calculate_moves(moves_available)
        possible_moves = []
        row, col = @value


        # Calculate and filter valid moves
        moves_available.each do |(dr, dc)|
          new_row, new_col = row + dr, col + dc
          if new_row.between?(0, 7) && new_col.between?(0, 7)
            possible_moves << [new_row, new_col]
          end
        end
        possible_moves
      end

      def get_pm
        return @possible_moves
      end
end

class Board_knight
    attr_accessor :board_knight

    def initialize(piece)
        @board_knight = create_board(piece)
    end

    def create_board(piece)
        grid = Array.new(8) { Array.new(8) }
        (0...8).each do |row|
          (0...8).each do |col|
            grid[row][col] = Node.new([row, col], piece)
          end
        end
        grid
    end

    def find_node(value)
        (0...8).each do |row|
          (0...8).each do |col|
            return @board_knight[row][col] if @board_knight[row][col].value == value
          end
        end
        nil # Return nil if the node is not found
    end

    def move (start_point, end_point)
        return p "invalid position entered" if !find_node(start_point) || !find_node(end_point)

        queue = [find_node(start_point)]
        parents = []
        found = false

        while found == false
          node = queue.shift

          if node == nil
          elsif node.value == end_point
            found = true
          else
              parents << node unless parents.include?(node)
          end

          node.get_pm.each do |possible|
            p node
            queue << find_node(possible) unless queue.include?(possible)
          end
        end

        correct_list = []
        current = end_point
        until found == false
          previous = parents.pop

          if previous == nil
            found = false
            break
          end

          if previous.possible_moves.include?(current)
            correct_list << previous.value
            current = previous.value
          end
        end

        correct_list = correct_list.reverse
        correct_list << end_point
        return correct_list
    end

    def start_search(start, end_point, piece)
      x = piece
      a = Board_knight.new(x)

      a.move(start, end_point)
    end
end
