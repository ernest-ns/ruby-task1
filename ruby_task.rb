class ResumeDetails
  attr_reader :name
  attr_reader :age
  attr_reader :address
  
  def name=(new_name)
    @name = new_name
  end
  
  def age=(new_age)
    @age = new_age.to_i
  end
  
  def address=(new_address)
    @address = new_address
  end
  
  def initialize(name, age, address)
    @name = name
    @age = age.to_i
    @address = address
  end
  
  def validate
 #   begin
      raise "invalid name" if( (@name.size ==0) || (@name.match(/([^\w])+/)) )
      raise "invalid age" if(  (@age == 0)    ||  (@age.to_s.match(/([^\d])+/) ) )
      raise "invalid address" if( (@address.size == 0) || (@address.match(/([^\w\d])+/) ))
#    rescue Exception => e
#      puts e.to_s
 #   end
  end
end

class InputOutput
  def read_from_console(obj=STDIN)
    entered_string = obj.gets.chomp
    return entered_string
  end
  
  def write_to_file(rd)
    rd.validate()
    file_entry = "#{rd.name},#{rd.age},#{rd.address}"

    File.open("resume_details.txt","a") do |file|
      file.puts file_entry
    end  
  end
  
end


=begin
class MainClass

  io =InputOutput.new
  
  puts "Enter The Name:"
  name = io.read_from_console()
  puts "Enter The Age:"
  age = io.read_from_console()
  puts "Enter The Address"
  address =io.read_from_console()

  rd = ResumeDetails.new(name,age,address)
  io.write_to_file(rd)
  puts "Data Written to file"
end
=end
