require './test/test_helper'
require 'entry'

class EntryTest < Minitest::Test
  def test_entry_attributes
    data = {
      regdate: '11/12/08 10:47',
      first_name: 'Allison',
      last_name: 'Nguyen',
      email_address: 'arannon@jumpstartlab.com',
      homephone: '6154385000',
      street: '3155 19th St NW',
      city: 'Washington',
      state: 'DC',
      zipcode: '20010'
    }
    entry = Entry.new(data)

    assert_equal '11/12/08 10:47', entry.reg_date
    assert_equal 'Allison', entry.first_name
    assert_equal 'Nguyen', entry.last_name
    assert_equal 'arannon@jumpstartlab.com', entry.email_address
    assert_equal '615.438.5000', entry.homephone
    assert_equal '3155 19th St NW', entry.street
    assert_equal 'Washington', entry.city
    assert_equal 'DC', entry.state
    assert_equal '20010', entry.zipcode
  end

  def test_homephone_invalid
    data = { homephone: '01234567890' }
    homephone = data[:homephone]
    assert Entry.new(data).invalid_homephone? homephone
  end

  def test_reformats_homephone
    data = { homephone: '11234567890' }
    assert_equal '(1) 123.456.7890', Entry.new(data).homephone
    # test 10-digit
  end

  def test_cleans_zipcodes
    data = { zipcode: '123' }
    assert_equal '00123', Entry.new(data).zipcode

    data = { zipcode: '12345678' }
    assert_equal '12345', Entry.new(data).zipcode

    data = { zipcode: nil }
    assert_equal '00000', Entry.new(data).zipcode
  end
end
