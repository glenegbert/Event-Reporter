class HelpMessage
  def self.help(command = nil)
    return help_command(command) if command
    available_commands.reduce("") { |text,command| text + help_command(command) + "\n" }
  end

  def self.help_command(command)
    case command
    when 'help' then 'help:  lists all available commands'
    when 'quit' then 'quit:  exit the program'
    when 'load' then 'load <filename.csv>:  erase any loaded data and parse the specified file'
    when 'queue count' then 'queue count:  counts the number of records in the current queue.'
    when 'queue clear' then 'queue clear:  empties the current queue. Queue will remain empty until the next find command.'
    when 'queue print' then 'queue print:  prints out a table of the queue.'
    when 'queue print by' then 'queue print by <attribute>:  prints out a table of the queue sorted by attribute.'
    when 'queue save to' then 'queue save to <filename.csv>:  exports the queue to the specified csv file. WARNING: saving will overwrite all file contents.'
    when 'find' then 'find <attribute> <criteria>:  load the queue with all records matching the criteria for the given attribute.'
    else "Invalid entry: #{command} is not a command."
    end
  end

  def self.available_commands
      ['help', 'quit', 'load', 'queue count', 'queue clear', 'queue print', 'queue print by', 'queue save to', 'find']
  end
end
