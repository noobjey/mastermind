require 'byebug'

class Mastermind
  attr_reader :solution


  def start
    greeting_header = 'Welcome to MASTERMIND'
    game_start_menu = 'Would you like to (p)lay, read the (i)nstructions, or (q)uit?'
    game_start_text = "I have generated a beginner sequence with four elements made up of: (r)ed,
(g)reen, (b)lue, and (y)ellow. Use (q)uit at any time to end the game.
What's your guess?"

    puts greeting_header
    puts game_start_menu

    user_input = ''

    until user_input == 'q'
      user_input = STDIN.gets.chomp

      case user_input.downcase
        when 'q'
          response 'Later Loser'
        when 'i'
          response "If you don't konw how to play already please just hit 'q' and go away"
        when 'p'
          @solution = generate_sequence(4).join
          response game_start_text
        when 'c'
          response cheating
        else
          response check_guess(user_input)
      end

    end

  end

  def cheating
    start_game_first_message = "Start the game before trying to cheat, duh"
    return start_game_first_message unless @solution

    solution_message = "Here's the answer cheater [ #{@solution} ]"
    return solution_message
  end

  private

  def check_guess(guess)
    guess.downcase!

    validation = ValidateGuess.new(guess)
    return validation.message unless validation.valid?

    you_won_message = "Congratulations! You guessed the sequence '#{@solution.upcase}'"
    return "Congratulations! You guessed the sequence '#{@solution.upcase}'" if @solution == guess
  end

  def generate_sequence(this_many)
    elements = ['r', 'g', 'b', 'y']
    this_many.times.map { |i| elements[rand(0..3)] }
  end

  def response(text)
    STDOUT.printf("#{text}:")
  end

end

class ValidateGuess

  def initialize(guess)
    @guess   = guess
    @message = ''
    @expected_guess_size = 4
  end

  def valid?
    to_short? && to_long?
  end

  def message
    "#{@message}, guess again Stupid"
  end

  private

  def to_short?
    if @guess.size < @expected_guess_size
      @message = "Guess is To Short (like the old rapper)"
      return false
    else
      return true
    end
  end

  def to_long?
    if @guess.size > @expected_guess_size
      @message = "Guess is to long"
      return false
    else
      return true
    end
  end
end

Mastermind.new().start
