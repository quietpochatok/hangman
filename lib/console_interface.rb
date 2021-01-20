require 'colorize'
require 'colorized_string'

class ConsoleInterface
  FIGURES =
    Dir["#{__dir__}/../data/figures/*.txt"].sort.map { |file_name| File.read(file_name) }

  def initialize(game)
    @game = game
  end

  def print_out
    puts <<~END
      Слово: #{word_to_show.colorize(:light_blue).on_white}
      #{figure.colorize(:red)}

      Ошибки ("#{@game.errors_made.to_s.colorize(:red).on_white.underline}"): #{errors_to_show}
      У вас осталось ошибок: #{@game.errors_allowed.to_s.colorize(:blue)}

      END

    if @game.won?
      puts "Поздравляем, вы выиграли!"
    elsif @game.lost?
      puts "Вы проиграли, загаданное слово #{@game.word_to_win.colorize(:blue)}"
    end
  end

  def figure
    FIGURES[@game.errors_made]
  end

  def word_to_show
    result =
      @game.letters_to_guess.map do |letter|
        # if letter == nil
        if letter.nil?
          '__'
        else
          letter
        end
      end
    result.join(' ')
  end

  def errors_to_show
    @game.errors.join(', ')
  end

  def get_input
    print 'Введите следующую букву: '
    gets[0].upcase
  end
end
