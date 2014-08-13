require 'help_message'
require 'processor'

class CLI
  attr_reader :reader, :writer, :processor
  
  include HelpMessage

  def initialize(reader = Reader.new($stdin), writer = Writer.new($stdout), processor = Processor.new)
    @reader = reader
    @writer = writer
    @processor = processor
    writer._print "Please load a csv file upon which to build a queue.\n"
  end

  def run
    command_parts = get_command # ? 
    command_domain = command_parts.part1
    return if command_domain == 'quit'
    help_command(command_parts) if command_domain == 'help'
    queue_command(command_parts) if command_domain == 'queue'
    load_command(command_parts) if command_domain == 'load'
    find_command(command_parts) if command_domain == 'find'
    writer._print invalid_message
    run
  end

  def help_command(command_parts)
    command_parts.part3 ? processor.help_commands(command_parts.part2 + ' ' + command_parts.part3) : processor.help_commands(command_parts.part2)
  end

  def queue_command
    
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
      interpret_input(command) if valid_command?(command)
    end

    CommandParts = Struct.new(:part1, :part2, :part3)
    def interpret_input(command)
      command.match(command_parser)
      part2 = part2.empty? ? nil : part2.tr(' ', '_') 
      part3 = nil if part3.empty?
      CommandParts.new(part1, part2, part3)
    end

    def valid_command?(command)
      available_commands.any? { |c| /#{c}/ =~ command }
    end

    def command_parser
      parser = /
               ^
               (?<part1>\w+)
               \s*
               (?<part2>\w*\s*(by|to)?)
               \s*
               (?<part3>\w*)
               /
    end
    
    def available_commands
      ['help', 'quit', 'load', 'queue count', 'queue clear', 'queue print', 'queue print by', 'queue save to', 'find']
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
