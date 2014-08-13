require 'entry'
require 'csv'

class RepositoryManager
  attr_reader :entries
  attr_accessor :queue

  def load_entries(file='event_attendees.csv')
    data = parse_csv(file)
    entries = data.map { |row| Entry.new(row) }

  end

  # def initialize(entries)
  def initialize
    @entries = []
    # @entries = entries
    @queue = []
  end

  def find(attribute, criteria)
    self.queue = entries.select { |entry| entry.send(attribute) =~ /\s*#{criteria}\s*/i }
  end

  private

  def parse_csv(file)
    file_path = File.join('./data', file)
    data = CSV.open(file_path, headers: true, header_converters: :symbol)
  end

end
