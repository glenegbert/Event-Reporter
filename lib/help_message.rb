module HelpMessage
  def help_commands(command = nil)
    return help(command) if command
    available_commands.reduce("") { |text,command| text + help(command) + "\n" }
  end

  def help(command)
    case command
    when 'load' then 'load <filename.csv>:  Erase any loaded data and parse the specified file'
    when 'count' then 'count:  counts the number of records in the current queue.'
    when 'clear' then 'clear:  empties the current queue. Queue will remain empty until the next find command.'
    when 'print' then 'print:  prints out a table of the queue.'
    when 'print by' then 'print by <attribute>:  prints out a table of the queue sorted by attribute.'
    when 'save to' then 'save to <filename.csv>:  exports the queue to the specified csv file. WARNING: saving will overwrite all file contents.'
    when 'find' then 'find <attribute> <criteria>:  Load the queue with all records matching the criteria for the given attribute.'
    else "Invalid entry: #{command} is not a command."
    end
  end

end

