require_relative './board'

def grab(board, turn)
  coordinates = get_valid_input.split.map { |coord| [coord[0], coord[1].to_i] }
  letters = "abcdefgh"

  if letters.index(coordinates[0][0]) === nil || letters.index(coordinates[1][0]) === nil
    p "Invalid place selected"
    return nil
  else
    start =[]
    start << coordinates[0][1] - 1
    start << letters.index(coordinates[0][0])

    finish =[]
    finish << coordinates[1][1] - 1
    finish << letters.index(coordinates[1][0])
    board.move(start, finish, turn)
  end
end

def perform_turn(turn, board)
  if turn % 2 == 0
    grab(board, "Black")
  else
    grab(board, "white")
  end
end

def validate_coordinates(input)
  # Define valid letters and number ranges
  valid_letters = "abcdefgh"
  valid_numbers = (1..8).to_a

  # Split the input into individual coordinates
  coordinates = input.split

  # Check if there are exactly two coordinates
  return "Invalid input: Please enter exactly two coordinates." unless coordinates.size == 2

  coordinates.each do |coord|
    letter, number = coord[0], coord[1].to_i

    # Validate letter
    return "Invalid input: Column must be a letter from 'a' to 'h'." unless valid_letters.include?(letter)

    # Validate number
    return "Invalid input: Row must be a number from 1 to 8." unless valid_numbers.include?(number)
  end

  # If all checks pass
  return nil
end
def get_valid_input
  loop do
    puts "Enter your coordinates (e.g., 'a1 a2'):"
    input = gets.strip
    error_message = validate_coordinates(input)

    if error_message
      puts error_message
    else
      return input
    end
  end
end

b = Board.new()
b.start_game
counter = 1

loop do
  current_player = counter.even? ? "Black" : "White"

  result = perform_turn(current_player, b)

  # If the result is nil, repeat the turn for the same player
  if result.nil?
    puts "#{current_player}'s turn is being repeated."
  else
    # Increment the counter to switch turns
    counter += 1
  end

  # Optional: Add a break condition for exiting the loop, e.g., game over condition
  # break if game_over?
end
# need to add error handling for when inputted in the wrong format
