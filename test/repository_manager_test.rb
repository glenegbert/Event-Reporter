require './test/test_helper'
require 'repository_manager'

class EntryRepositoryTest < Minitest::Test
  def test_loads_entries
    entries = [
      { first_name: 'Alice', last_name: 'Smith', homephone: '111.111.1111' },
      { first_name: 'Bob', last_name: 'Smith', homephone: '222.222.2222' },
      { first_name: 'Cindy ', last_name: 'johnson', homephone: '333.333.3333' }
    ].map { |row| Entry.new(row) }

    entries = RepositoryManager.new(entries).entries
    assert_equal 3, entries.length

    alice, bob = entries

    assert_equal "Alice", alice.first_name
    assert_equal "111.111.1111", alice.homephone
    assert_equal "Bob", bob.first_name
    assert_equal "222.222.2222", bob.homephone
  end

  def test_find_by
    entries = [
      { first_name: 'Alice ', last_name: 'Smith', homephone: '111.111.1111' },
      { first_name: 'bob', last_name: 'Smith', homephone: '222.222.2222' },
      { first_name: '   CiNdy     ', last_name: 'johnson', homephone: '333.333.3333' }
    ].map { |row| Entry.new(row) }

    repository = RepositoryManager.new(entries)
    repository.find_by(:first_name, 'Alice')

    assert_equal 1, repository.queue.length

    assert_equal 'Alice ', repository.queue[0].first_name
  end
end
