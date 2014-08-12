require 'repository_manager'
require 'entry'

class Processor

  attr_accessor :repository_manager

  def initialize(repository_manager = RepositoryManager.load_entries)
    @repository_manager = repository_manager
  end

  def print_out
    #"LAST NAME".ljust(24, " ") + "FIRST NAME".ljust(24, " ") + "EMAIL".ljust(24, " ") + "ZIPCODE".ljust(12, " ") + "CITY".ljust(24, " ") + "STATE".ljust(20, " ") + "ADDRESS".ljust(28, " ") + "PHONE".ljust(18, " ")
    repository_manager.queue.map { |x| "#{x.last_name}".ljust(24, " ") + "#{x.first_name}".ljust(24, " ") + "#{x.email_address}".ljust(24, " ") + "#{x.zipcode}".ljust(12, " ")  + "#{x.city}".ljust(24, " ")  + "#{x.state}".ljust(20, " ") + "#{x.street}".ljust(28, " ") + "#{x.homephone}".ljust(18," ")}
  end

  def print_by(field)
      case field
      when "regdate" then repository_manager.queue.sort_by {|entry| entry.regdate}.map{|x| "#{x.last_name}".ljust(24, " ") + "#{x.first_name}".ljust(24, " ") + "#{x.email_address}".ljust(24, " ") + "#{x.zipcode}".ljust(12, " ")  + "#{x.city}".ljust(24, " ")  + "#{x.state}".ljust(20, " ") + "#{x.street}".ljust(28, " ") + "#{x.homephone}".ljust(18," ")}
      when "first_name" then repository_manager.queue.sort_by {|entry| entry.first_name}.map{|x| "#{x.last_name}".ljust(24, " ") + "#{x.first_name}".ljust(24, " ") + "#{x.email_address}".ljust(24, " ") + "#{x.zipcode}".ljust(12, " ")  + "#{x.city}".ljust(24, " ")  + "#{x.state}".ljust(20, " ") + "#{x.street}".ljust(28, " ") + "#{x.homephone}".ljust(18," ")}
      when "last_name" then repository_manager.queue.sort_by {|entry| entry.last_name}.map{|x| "#{x.last_name}".ljust(24, " ") + "#{x.first_name}".ljust(24, " ") + "#{x.email_address}".ljust(24, " ") + "#{x.zipcode}".ljust(12, " ")  + "#{x.city}".ljust(24, " ")  + "#{x.state}".ljust(20, " ") + "#{x.street}".ljust(28, " ") + "#{x.homephone}".ljust(18," ")}
      when "email_address" then repository_manager.queue.sort_by {|entry| entry.email_address}.map{|x| "#{x.last_name}".ljust(24, " ") + "#{x.first_name}".ljust(24, " ") + "#{x.email_address}".ljust(24, " ") + "#{x.zipcode}".ljust(12, " ")  + "#{x.city}".ljust(24, " ")  + "#{x.state}".ljust(20, " ") + "#{x.street}".ljust(28, " ") + "#{x.homephone}".ljust(18," ")}
      when "home_phone" then repository_manager.queue.sort_by {|entry| entry.home_phone}.map{|x| "#{x.last_name}".ljust(24, " ") + "#{x.first_name}".ljust(24, " ") + "#{x.email_address}".ljust(24, " ") + "#{x.zipcode}".ljust(12, " ")  + "#{x.city}".ljust(24, " ")  + "#{x.state}".ljust(20, " ") + "#{x.street}".ljust(28, " ") + "#{x.homephone}".ljust(18," ")}
      when "street" then repository_manager.queue.sort_by {|entry| entry.street}.map{|x| "#{x.last_name}".ljust(24, " ") + "#{x.first_name}".ljust(24, " ") + "#{x.email_address}".ljust(24, " ") + "#{x.zipcode}".ljust(12, " ")  + "#{x.city}".ljust(24, " ")  + "#{x.state}".ljust(20, " ") + "#{x.street}".ljust(28, " ") + "#{x.homephone}".ljust(18," ")}
      when "city" then repository_manager.queue.sort_by {|entry| entry.city}.map{|x| "#{x.last_name}".ljust(24, " ") + "#{x.first_name}".ljust(24, " ") + "#{x.email_address}".ljust(24, " ") + "#{x.zipcode}".ljust(12, " ")  + "#{x.city}".ljust(24, " ")  + "#{x.state}".ljust(20, " ") + "#{x.street}".ljust(28, " ") + "#{x.homephone}".ljust(18," ")}
      when "state" then repository_manager.queue.sort_by {|entry| entry.state}.map{|x| "#{x.last_name}".ljust(24, " ") + "#{x.first_name}".ljust(24, " ") + "#{x.email_address}".ljust(24, " ") + "#{x.zipcode}".ljust(12, " ")  + "#{x.city}".ljust(24, " ")  + "#{x.state}".ljust(20, " ") + "#{x.street}".ljust(28, " ") + "#{x.homephone}".ljust(18," ")}
      when "zipcode" then repository_manager.queue.sort_by {|entry| entry.zipcode}.map{|x| "#{x.last_name}".ljust(24, " ") + "#{x.first_name}".ljust(24, " ") + "#{x.email_address}".ljust(24, " ") + "#{x.zipcode}".ljust(12, " ")  + "#{x.city}".ljust(24, " ")  + "#{x.state}".ljust(20, " ") + "#{x.street}".ljust(28, " ") + "#{x.homephone}".ljust(18," ")}
      end
  end

  def queue_count
    repository_manager.queue.length
  end

 # def load_entries(directory, file)
 #   RepositoryManager.load_entries(directory,file)
 # end

  def find(field, match)

    case field
    when "regdate" then repository_manager.queue = repository_manager.entries.select{ |entry| entry.regdate == match}
    when "first_name" then repository_manager.queue = repository_manager.entries.select{ |entry| entry.first_name == match}
    when "last_name" then repository_manager.queue = repository_manager.entries.select{ |entry| entry.last_name == match}
    when "email_address" then repository_manager.queue = repository_manager.entries.select{ |entry| entry.email_address == match}
    when "home_phone" then repository_manager.queue = repository_manager.entries.select{ |entry| entry.home_phone == match}
    when "street" then repository_manager.queue = repository_manager.entries.select{ |entry| entry.street == match}
    when "city" then repository_manager.queue = repository_manager.entries.select{ |entry| entry.city == match}
    when "state" then repository_manager.queue = repository_manager.entries.select{ |entry| entry.state == match}
    when "zipcode" then repository_manager.queue = repository_manager.entries.select{ |entry| entry.zipcode == match}
    end

  end

  def save_queue(to_file="saved_data.csv")
    File.open(to_file, "w") do |file|
      file.puts "LAST NAME".ljust(24, " ") + "FIRST NAME".ljust(24, " ") + "EMAIL".ljust(24, " ") + "ZIPCODE".ljust(12, " ") + "CITY".ljust(24, " ") + "STATE".ljust(20, " ") + "ADDRESS".ljust(28, " ") + "PHONE".ljust(18, " ")
       @repository_manager.queue.each do |entry| file.puts "#{entry.last_name}".ljust(24, " ") + "#{entry.first_name}".ljust(24, " ") + "#{entry.email_address}".ljust(24, " ") + "#{entry.zipcode}".ljust(12, " ")  + "#{entry.city}".ljust(24, " ")  + "#{entry.state}".ljust(20, " ") + "#{entry.street}".ljust(28, " ") + "#{entry.home_phone}".ljust(18," ")
       end
    end
 end

end
