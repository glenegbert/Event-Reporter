require 'command_processor'
require 'repository_manager'
require 'glens_help_message'


class CLI

attr_reader :command_processor

  def initialize
    @command_processor = CommandProcessor.new
  end

  def start
    puts "Please Enter a Command"
    answer = gets.chomp.strip
    until answer == "q" do
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
            then command_processor.repository_manager.load_entries
          else command_processor.repository_manager.load_entries(word_array[1])
        end
      when "help"
        if word_count == 1
        puts HelpMessage.help
        elsif word_count == 2
        puts HelpMessage.help_command(word_array[1])
        elsif word_count == 3
        puts HelpMessage.help_command(word_array[1] + " " + word_array[2])
        else puts HelpMessage.help_command(word_array[1] + " " + word_array[2] + " " + word_array[3])
        end
      when "queue"
        if word_count == 2
        command_processor.send(word_array[0] + "_" + word_array[1])
        elsif word_array[2] == "by"
          command_processor.queue_print_by(word_array[3])
        elsif word_array[2] == "to"
          command_processor.queue_save_to(word_array[3])
        end
      when "find"
        command_processor.repository_manager.find(word_array[1],word_array[2])
      end
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
