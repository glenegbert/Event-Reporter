class Entry
attr_reader :reg_date, 
            :first_name, 
            :last_name, 
            :email_address,
            :homephone, 
            :street, 
            :city, 
            :state,
            :zipcode

  def initialize(data)
    @reg_date = data[:regdate]
    @first_name = data[:first_name]
    @last_name = data[:last_name]
    @email_address = data[:email_address]
    @homephone = clean_phone_number(data[:homephone])
    @street = data[:street]
    @city = data[:city]
    @state = data[:state]
    @zipcode = clean_zipcode(data[:zipcode])
  end

  def clean_phone_number(homephone)
    # abstract out valid homephones, then use this method for case
    homephone = homephone.to_s.tr('^0-9', '')
    return 'No valid phone number.' if invalid_homephone? homephone
    return homephone.gsub(/(\d{3})(\d{3})(\d{4})/, '\1.\2.\3') if homephone.size == 10 
    return homephone.gsub(/(\d{1})(\d{3})(\d{3})(\d{4})/, '(\1) \2.\3.\4') if homephone.size == 11 
  end

  def invalid_homephone? homephone
    homephone.size < 10 || homephone.size > 11 || (homephone.size == 11 && homephone[0] != "1")
  end

  def clean_zipcode(zipcode)
    zipcode.to_s.rjust(5, '0')[0..4]
  end
  
end
