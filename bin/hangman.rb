# frozen_string_literal: true

# Hangman is a class that represents the game of Hangman.
# It provides methods for starting and playing the game.
class Hangman
  FILE_PATH = 'bin/google-10000-english-words.txt'

  # @return [Object]
  def save_game
    # code here use serializing objects
  end

  def start
    puts "select one Option: 1. new game or 2. saved game"

    option_selected = gets

    case option_selected
    when 1
      new_game
    when 2
      save_game
    else
      exit
    end
  end

  def new_game

    answer = random_word
    puts answer

    new_word = hide_word(answer)

    puts new_word

    game_state = false

    until game_state

      input_letter

      if new_word == answer
        game_state = true
        puts 'Congrats, You Win!'
      else
        input_letter
      end
    end
  end

  def random_word
    file_content = []

    File.open(FILE_PATH, 'r').each_line do |line|
      file_content << line.chomp
    end

    size = file_content.size

    check_word(file_content, size)
  end

  private

  def check_word(file_content, size)
    is_correct = true
    while is_correct
      word = file_content[random_number(size)]
      is_correct = false if word.length >= 5 && word.length <= 12
    end
    word
  end

  def random_number(size)
    rand(size)
  end

  def hide_word(word)
    word.gsub(/[a-zA-Z]/) do |_char|
      '_'
    end
  end

  # @return [String]
  def input_letter
    puts 'Please enter a letter: '
    input = gets.chomp.downcase

    is_correct = false

    until is_correct
      if contains_only_letters?(input) && input.length == 1
        return input
      else
        puts 'Please enter a valid single letter.'
        input = gets.chomp.downcase
      end
    end
  end

  def contains_only_letters?(word)
    /^[a-zA-Z]+$/.match?(word)
  end

  def check_answer(word, input)
    arr = []
    word.each_char do |char|
      arr << char
    end
    correct_letter?(arr, input)
  end

  def correct_letter?(arr, letter)
    arr.each_with_index do |i, index|
      return index if i == letter
    end
    '_'
  end
end
