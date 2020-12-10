if Gem.win_platform?
  Encoding.default_external = Encoding.find(Encoding.locale_charmap)
  Encoding.default_internal = __ENCODING__

  [STDIN, STDOUT].each do |io|
    io.set_encoding(Encoding.default_external, Encoding.default_internal)
  end
end

require_relative 'lib/console_interface'
require_relative 'lib/game'

# 1. Поздороваться с пользователем
puts "Приветствую!"

# 2. Загрузить случайное слово из файла
sample_word_for_game = File.readlines("#{__dir__}/data/words.txt", encoding: 'UTF-8', chomp: true).sample

# Создание игры самой.
game = Game.new(sample_word_for_game)
console_interface = ConsoleInterface.new(game)

# 3. Пока не закончилась игра
until game.over?
#   3.1. Вывести чередное  состояние игры
  console_interface.print_out
#   3.2. Спросить очередную букву
  letter_from_gets = console_interface.get_input
#   3.3. Обновление состояние игры
  game.play!(letter_from_gets)
end

# 4. Вывести финальное состояние игры
console_interface.print_out






