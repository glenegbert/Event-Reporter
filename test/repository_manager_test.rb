require './test/test_helper'
require 'repository_manager'

class EntryRepositoryTest < Minitest::Test
  def test_loads_entries
    repository_manager = RepositoryManager.new
    repository_manager.load_entries('event_two_attendees.csv')
    assert_equal 9, repository_manager.entries.length
  end

  def test_find_by
    # entries = [
    #   { first_name: 'Alice ', last_name: 'Smith', homephone: '111.111.1111' },
    #   { first_name: 'bob', last_name: 'Smith', homephone: '222.222.2222' },
    #   { first_name: '   CiNdy     ', last_name: 'johnson', homephone: '333.333.3333' }
    # ].map { |row| Entry.new(row) }

    repository_manager = RepositoryManager.new
    repository_manager.load_entries('event_two_attendees.csv')
    repository_manager.find_by(:first_name, 'sarah')

    assert_equal 2, repository_manager.queue.length

    assert_equal 'SArah', repository_manager.queue[0].first_name
  end
end
