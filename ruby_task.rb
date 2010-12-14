class ResumeDetails
  attr_reader :name
  attr_reader :age
  attr_reader :address
  
    
  def initialize(name, age, address)
    @name = name
    @age = age.to_i
    @address = address
  end
end

class InputOutput
  def read_from_console(obj=STDIN)
    entered_string = obj.gets
    return entered_string
  end
end
