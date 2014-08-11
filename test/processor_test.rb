require './test/test_helper'
require 'processor'

class ProcessorTest < Minitest::Test

  def test_queue_is_cleared
    processor = Processor.new
    processor.repository_manager.queue << Entry.new({first_name: "Alice"})
    assert_equal 1, processor.repository_manager.queue.length
    assert_equal [], processor.repository_manager.queue.clear
  end

  def test_queue_can_be_printed
skip
    processor = Processor.new
    assert processor.print_out[0].include?("Glen")
    assert processor.print_out[1].include?("Brown")
  end

  def test_queue_can_be_sorted_before_printing
skip
    processor = Processor.new

    assert processor.print_by("city")[0].include?("Downtown")
  end

  def test_number_records_que_can_be_counted
skip
      processor = Processor.new

      assert_equal 2, processor.queue_count
  end

  def test_data_can_be_loaded_to_a_repository_manager
    data = [{:regdate => "11/12/08 10:47", :first_name => "Glen",:last_name => "Egbert",
      :email_address => "123@gmail.com", :home_phone => "303.564.9379", :street => "326 Wright Street",
      :city => "Lakewood", :state => "CO", :zipcode => "80228"}, {:regdate => "11/12/08 10:47", :first_name => "James",
      :last_name => "Brown", :email_address => "shebang@gmail.com", :home_phone => "303.123.9379", :street => "123 Get on Up Street",
      :city => "Downtown", :state => "CO", :zipcode => "87543"}]

    processor = Processor.new
    processor.repository_manager.instance_variable_set(:@entries, data.map { |row| Entry.new(row) })
    assert_equal 2, processor.repository_manager.entries.length

    processor = Processor.new
    assert_operator processor.repository_manager.entries.length, :>, 2
  end

  def test_data_can_be_loaded_into_the_queue
skip
      data =   [{:regdate => "11/12/08 10:47", :first_name => "Glen",:last_name => "Egbert",
      :email_address => "123@gmail.com", :home_phone => "303.564.9379", :street => "326 Wright Street",
      :city => "Lakewood", :state => "CO", :zipcode => "80228"}, {:regdate => "11/12/08 10:47", :first_name => "James",
      :last_name => "Brown", :email_address => "shebang@gmail.com", :home_phone => "303.123.9379", :street => "123 Get on Up Street",
      :city => "Downtown", :state => "CO", :zipcode => "87543"}]

    processor = Processor.new

    processor.load_data(data)
    processor.clear

    assert processor.repository_manager.queue == []

    processor.find("zipcode", "80228")

    assert processor.print_out[0].include?("Glen")

  end

  def test_data_in_queue_can_be_saved_to_a_file
skip
    processor = Processor.new

    processor.save_queue("saved_data.csv")

    assert File.exist? "saved_data.csv"

  end
end

