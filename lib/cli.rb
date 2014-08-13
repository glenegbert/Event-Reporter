require 'help_message'

class CLI
  attr_reader :reader, :writer
  
  include HelpMessage

  def initialize(reader = Reader.new($stdin), writer = Writer.new($stdout))
    @reader = reader
    @writer = writer
    writer._print "Please load a csv file upon which to build a queue.\n 
                   Enter 'help' for help using this program."
  end

  def run
    command = get_command 
  end

  def get_command
    command = reader.read_command
    return command if command 
    writer._print invalid_message 
    get_command
  end
  
  class Reader
    def initialize(input_stream)
      @input_stream = input_stream
    end

    def read_command
      command = gets.strip.downcase
      interpret_input command
    end

    def interpret_input(command)
      command = command.split(' ')
      return command if command
    end

    def available_commands
      ['load', 'count', 'clear', 'print', 'print by', 'save to', 'find']
    end

    private
      attr_reader :input_stream
  end

  class Writer
    def initialize(output_stream)
      @output_stream = output_stream
    end

    def _print(message)
      output_stream.print message
    end

    def prompt
      '>>'
    end

    def invalid_message
      "Invalid command. Enter 'help' for a list of valid commands."
    end

    private
      attr_reader :output_stream
  end

end
