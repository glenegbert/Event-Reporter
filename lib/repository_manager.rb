require 'entry'
require 'csv'

class RepositoryManager
  attr_reader :entries
  attr_accessor :queue

  def self.load_entries(directory='./data', file='event_attendees.csv')
    file = File.join(directory, file)
    data = CSV.open(file, headers: true, header_converters: :symbol)
    rows = data.map do |row|
      Entry.new(row)
    end
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
