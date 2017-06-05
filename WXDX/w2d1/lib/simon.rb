class Simon
  COLORS = %w(red blue green yellow)

  attr_accessor :sequence_length, :game_over, :seq

  def initialize
    @sequence_length = 1
    @game_over = false
    @seq = []
  end

  def play
    take_turn until game_over
    game_over_message
    reset_game
  end


  def take_turn
    show_sequence
    require_sequence
    unless game_over
      round_success_message
      @sequence_length+=1
    end
  end

  def show_sequence
    add_random_color
     p @seq
     sleep(1)
    system("clear")
  end

  def require_sequence #ask user for color guess
    p "Please guess the colors separated by a space"
    guess = gets.chomp
    if guess.downcase.split != @seq
      @game_over = true
    end
  end

  def add_random_color
    @seq << COLORS.sample
  end

  def round_success_message
    p "You got it dude!"
  end

  def game_over_message
    p "GAME OVER"
  end

  def reset_game
    @sequence_length = 1
    @game_over = false
    @seq = []

    p "Would you like to play a new game? y/n?"
    Simon.new.play if gets.chomp == "y"
  end
end


if __FILE__ == $PROGRAM_NAME
  game = Simon.new
  game.play
end

# game = Simon.new
# game.play
