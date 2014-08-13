require 'command_processor'
require 'repository_manager'

class CLI
  def initialize
    @command_processor = CommandProcessor.new
  end

  def start
    puts "Please Enter a Command"
    answer = gets.chomp.strip
    unless answer == "q" || answer == "quit"
      process_commands(answer)
      puts "Please Enter a Command"
      answer = gets.chomp.strip
    end
  end

  def process_commands(answer)
    first_word = determine_first_word(answer)
    word_count = determine_word_count(answer)
    word_array = set_word_array(answer)
    case first_word
    when "load"
      if word_count == 1
      then @command_processor.repository_manager.load_entries
      else command_processor.repository_manager.load_entries(word_array[1])
      end
    end
    command_processor.repository_manager.entries
  end

  def determine_first_word(answer)
    answer.split(" ").first
  end

  def determine_word_count(answer)
    answer.split(" ").length
  end

  def set_word_array(answer)
    answer.split(" ")
  end
end


# ruby -Ilib lib/glens_cli.rb
