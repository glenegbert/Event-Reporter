module HelpMessage
  def help_commands(command = nil)
    return help(command) if command
    available_commands.reduce("") { |text,command| text + help(command) + "\n" }
  end

  def help(command)
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
    else "Invalid entry: #{command} is not a command.\nThe following are all valid commands.\n"; help_commands
    end
  end

end

