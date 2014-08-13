require 'help_message'
require 'processor'

class CLI
  attr_reader :reader, :writer, :processor
  
  include HelpMessage

  def initialize(reader = Reader.new($stdin), writer = Writer.new($stdout), processor = Processor.new)
    @reader = reader
    @writer = writer
    @processor = processor
    writer._print "Please first load a csv file upon which to build a queue.\n"
  end

  def run
    writer._print prompt
    command_parts = reader.get_command  
    command_parts ? send(command_parts.part_1, command_parts) : rerun 
  end

  def rerun
    writer._print invalid_message
    run
  end

  def help_command(command_parts)
    command_parts.part3 ? processor.help(command_parts.part2 + ' ' + command_parts.part3) : processor.help(command_parts.part2)
  end

  def queue
    rerun unless command_parts.part2
    command_parts.part3 ? processor.send('queue' + '_' + command_parts.part2, command_parts.part3) : processor.send('queue' + '_' + command_parts.part2) 
  end

  def load
    command_parts.part2 ? processor.load(command_parts.part_2) : processor.load
  end

  def find
    rerun unless command_parts.part2 && command_parts.part3    
    processor.find(command_parts.part2, command_parts.part3)
  end

  def quit
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
      parse_command(command) if valid_command?(command)
    end

    CommandParts = Struct.new(:part1, :part2, :part3)
    def parse_command(command)
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
               (?<part3>\w*\s*(by|to)?)
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
      "Invalid command or use of command. Enter 'help' for a list of valid commands."
    end

    private
    attr_reader :output_stream
  end

end
