class PersonDetails
  def read_from_console(entered_string = "This. is. a. test. string.")
    entered_string = gets
    return entered_string
  end
  pd = PersonDetails.new
  puts "the entered string is ::  #{pd.read_from_console()}"
end
