require 'rubygems'
require 'pdf/toolkit'
require 'pdf/writer'

class ResumeDetails
  attr_reader :name
  attr_reader :age
  attr_reader :address
  attr_reader :file_type
  
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
    
  def initialize(name, age, address , file_type ="txt" )
    @name = name
    @age = age.to_i
    @address = address
    @file_type = file_type
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
  def write_to_pdf(file_name,file_entry)
    resume = PDF::Toolkit.open(file_name)
    resume_file_text = resume.to_text.read
    resume_file_text = resume_file_text+file_entry
    resume = PDF::Writer.new()
    resume.text(resume_file_text)
    resume_file_stream = resume.render()
    File.open(file_name , "w") do |file|
      file.puts resume_file_stream
    end
  end

  def write_to_txt(file_name,file_entry)
    File.open(file_name,"a") do |file|
      file.puts file_entry
    end
  end
  
  
  def read_from_console(obj=STDIN)
    entered_string = obj.gets.chomp
    return entered_string
  end
  
  def write_to_file(rd)
    rd.validate()
    file_entry = "#{rd.name},#{rd.age},#{rd.address}"

    if(rd.file_type == "pdf") :
      write_to_pdf("resume_details.pdf",file_entry)  
    else
      write_to_txt("resume_details.txt",file_entry)
    end  
  end
end


#=begin
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
#=end
