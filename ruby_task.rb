require 'rubygems'
require 'pdf/toolkit'
require 'pdf/writer'
require 'ruby_task_pdf'
require 'ruby_task_txt'

class ResumeDetails
  attr_reader :name
  attr_reader :age
  attr_reader :address
  attr_reader :file_type
  attr_reader :resume_file_name
  
  def name=(new_name)
    @name = new_name
  end
  
  def age=(new_age)
    @age = new_age.to_i
  end
  
  def address=(new_address)
    @address = new_address
  end

  def file_type=(new_file_type)
    @file_type = new_file_type
  end

  def resume_file_name=(new_resume_file_name)
    @resume_file_name = new_resume_file_name
  end
  
    
  def initialize(name, age, address , file_type ="txt" )
    @name = name
    @age = age.to_i
    @address = address
    @file_type = file_type
    @resume_file_name = "resume_details"
  end
  
  def validate
 #   begin
      raise "invalid name" if( (@name.size ==0) || (@name.match(/([^\w\s])+/)) )
      raise "invalid age" if(  (@age == 0)    ||  (@age.to_s.match(/([^\d])+/) ) )
      raise "invalid address" if( (@address.size == 0) || (@address.match(/([^\w\d\s])+/) ))
      raise "invalid file type" if( (@file_type.size == 0) || (@file_type.match(/[^txt|pdf]/) ) )
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

  def create_document(file_type) #returns an object of the file type depending  on the parameters passed
    return (eval( file_type.capitalize+".new"  ) )
  end
  
  def write_to_file(rd)
    rd.validate()
    file_entry = "#{rd.name},#{rd.age},#{rd.address}"
    file_name = rd.resume_file_name+"."+rd.file_type
#    eval(rd.file_type.capitalize+".append_to_file(file_name,file_entry)")
    #create an object
    file_obj = create_document(rd.file_type)
    file_obj.append_to_file(file_name,file_entry)
    #call the method on that object
  end
end


begin
class MainClass

  io =InputOutput.new
  
  puts "Enter The Name:"
  name = io.read_from_console()
  puts "Enter The Age:"
  age = io.read_from_console()
  puts "Enter The Address"
  address =io.read_from_console()
  puts "Enter the file type of the resume 'txt' for a text file and 'pdf' for a odf file"
  file_type = io.read_from_console()

  rd = ResumeDetails.new(name,age,address,file_type)
  io.write_to_file(rd)
  puts "Data Written to file"
end
end
