class Game
  TOTAL_ERRORS_ALLOWED = 7

  def initialize(word)
    @letters = word.chars
    @user_guesses = []
  end

  def over?
    won? || lost?
  end

  def normalize_letter(letter)
    if letter == 'Ё'
      letter = 'Е'
    elsif letter == 'Й'
      letter = 'И'
    else
      letter
    end
  end

  def play!(letter_user)
    letter_right = normalize_letter(letter_user)

    if !over? && !@user_guesses.include?(letter_right)
        @user_guesses << letter_right
    end
  end

  def normalized_letters
    @letters.map { |letter| normalize_letter(letter) }
  end

  def errors
    return @user_guesses - normalized_letters
  end

  def errors_made
    errors.size
  end

  def errors_allowed
    TOTAL_ERRORS_ALLOWED - errors_made
  end

  def letters_to_guess
    result =

      @letters.map do |letter|
        normalized = normalize_letter(letter)

        if @user_guesses.include?(normalized)
          letter
        end
      end
    return result
  end

  def word_to_win
     @letters.join
  end

  def won?
    (normalized_letters - @user_guesses).empty?
  end

  def lost?
    errors_allowed == 0
  end
end
