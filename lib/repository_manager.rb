require 'entry'  # ~> LoadError: cannot load such file -- entry
require 'csv'

class RepositoryManager
  attr_accessor :queue, :entries

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

  def load_entries(file='event_attendees.csv')
    data = parse_csv(file)
    @entries = data.map { |row| Entry.new(row) }
    @queue = []
  end

  def find(attribute, criteria)
    self.queue = entries.select { |entry| entry.send(attribute) =~ /^#{criteria}$/i }
    # self.queue = entries.select { |entry| entry.send(attribute).downcase == "#{criteria.downcase}" }
  end

  private

  def parse_csv(file)
    file_path = File.join('./test/data', file)
    data = CSV.open(file_path, headers: true, header_converters: :symbol)
  end

end
