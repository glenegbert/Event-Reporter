require 'entry'
require 'csv'

class RepositoryManager
  attr_reader :entries
  attr_accessor :queue

  def self.load_entries(file='event_attendees.csv')
    #Explore abstracting into multiple methods
    file = File.join('./data', file)
    data = CSV.open(file, headers: true, header_converters: :symbol)
    rows = data.map { |row| Entry.new(row) }
    new(rows)
  end

  def initialize(entries)
    @entries = entries
    @queue = []
  end

  def find_by(attribute,criteria)
    self.queue = entries.select { |entry| entry.send(attribute) =~ /\s*#{criteria}\s*/i }
  end

end
