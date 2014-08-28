require 'repository_manager'
require 'entry'

class CommandProcessor

  attr_accessor :repository_manager

  # def initialize(repository_manager = RepositoryManager.load_entries)
  def initialize(repository_manager = RepositoryManager.new)
    @repository_manager = repository_manager
  end

  def queue_print
    puts headers
    repository_manager.queue.map { |entry| entry_format(entry)}
  end

  def headers
    "LAST NAME".ljust(24, " ") + "FIRST NAME".ljust(24, " ") + "EMAIL".ljust(40, " ") + "ZIPCODE".ljust(12, " ") + "CITY".ljust(35, " ") + "STATE".ljust(20, " ") + "ADDRESS".ljust(36, " ") + "PHONE".ljust(18, " ")
  end

  def queue_print_by(field)
      puts headers
      repository_manager.queue.sort_by {|entry| entry.send(field)}.map{|entry| entry_format(entry)}
  end

  def entry_format(entry)
    "#{entry.last_name}".ljust(24, " ")+
    "#{entry.first_name}".ljust(24, " ")+
    "#{entry.email_address}".ljust(40, " ")+
    "#{entry.zipcode}".ljust(12, " ")+
    "#{entry.city}".ljust(35, " ")+
    "#{entry.state}".ljust(20, " ")+
    "#{entry.street}".ljust(36, " ")+
    "#{entry.homephone}".ljust(18," ")
  end

  def save_format(entry)
    "#{entry.reg_date}," +
    "#{entry.last_name}," +
    "#{entry.first_name}," +
    "#{entry.email_address}," +
    "#{entry.homephone}," +
    "#{entry.street}," +
    "#{entry.city}," +
    "#{entry.state}," +
    "#{entry.zipcode}"

  end

  def queue_count
    repository_manager.queue.length
  end


  def queue_save_to(to_file="saved_data.csv")
    file_path = File.join('./test/data', to_file)
    File.open(file_path, "w") do |file|
      file.puts " ,RegDate,first_Name,last_Name,Email_Address,HomePhone,Street,City,State,Zipcode"

      @repository_manager.queue.each { |entry| file.puts save_format(entry) }
      # file.puts @repository_manager.queue.each{|entry| puts entry_format(entry)}
      end
   end

   def queue_clear
    repository_manager.queue = []
   end

end

#refactor
#split out some classes
#
