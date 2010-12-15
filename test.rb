require 'ruby_task'
require 'test/unit'
require 'rubygems'
require 'pdf/toolkit'

class TestResume < Test::Unit::TestCase

  def test_acessor_methods
    rd = ResumeDetails.new("ernest",20,"dharwad","txt")
    rd.name = "aditya"
    rd.age = "12"
    rd.address = "hubli"
    rd.file_type = "pdf"
    assert_equal("aditya" , rd.name,"name not same")
    assert_equal(12 , rd.age, "age not same")
    assert_equal("hubli" ,rd.address,"address not same")
    assert_equal("pdf",rd.file_type, "filetype is not the same")
  end
  
  
  def test_valid_file_write
    io = InputOutput.new
    rd = ResumeDetails.new("ernest",22,"dharwad","txt")
    assert_nothing_raised() {io.write_to_file(rd)}
  end
  
  def test_invalid_file_write
    io = InputOutput.new
    rd = ResumeDetails.new("",0,"","doc")
    rd1 = ResumeDetails.new("aditya",123,"","xsl")
    assert_raise(RuntimeError) {io.write_to_file(rd)}
    assert_raise(RuntimeError) {io.write_to_file(rd1)}
  end
  
  def test_empty_instance
    assert_raise(ArgumentError) {rd = ResumeDetails.new()}
  end
  
  def test_initalized_instance
    rd = ResumeDetails.new("ernest","22","dharwad","txt")
    assert_equal("ernest",rd.name,"name is not as expected")
    assert_equal(22 , rd.age ,"age is not as expected")
    assert_equal("dharwad" , rd.address,"address is not as expected")
    assert_equal("txt" , rd.file_type , "filetype is not initailized as expected")
  end
  
  def test_wirte_to_file
    rd = ResumeDetails.new("abc",12,"qwe","txt")
    file_text = ""
    file_name = "resume_details."+rd.file_type
    if(rd.file_type == "pdf") :
      my_file = PDF::Toolkit.open(file_name)
      file_text = my_file.to_text.read
    else
      File.open(file_name) do|file|
        while line = file.gets
          file_text += line
        end
      end
    end
     assert_not_equal(0 , file_text.size,"the file is empty")
  end
  
  def test_read_from_console
    io = InputOutput.new()
    dummy_console = File.new("testfile")
    entered_string = io.read_from_console(dummy_console)
    assert_match(%r{[(\w).]+},entered_string,"the entered text is not a string")
  end


end
