require_relative './board'

def grab(board)
  puts "Enter your coordinates (e.g., 'a2 a3'):"
  input = gets.strip
  coordinates = input.split.map { |coord| [coord[0], coord[1].to_i] }
  letters = "abcdefgh"

  if letters.index(coordinates[0][0]) === nil || letters.index(coordinates[1][0]) === nil
    p "invalid place selected"
    #grab(board)
  else
    start =[]
    start << coordinates[0][1] - 1
    start << letters.index(coordinates[0][0])


    finish =[]
    finish << coordinates[1][1] - 1
    finish << letters.index(coordinates[1][0])
    board.move(start, finish)
  end
end


b = Board.new()
b.start_game

while true
  grab(b)
end




# probably some more just ant find them right now
