require 'ruby_task'
require 'test/unit'

class TestResume < Test::Unit::TestCase

  def test_acessor_methods
    rd = ResumeDetails.new("ernest",20,"dharwad")
    rd.name = "aditya"
    rd.age = "12"
    rd.address = "hubli"
    assert_equal("aditya" , rd.name,"name not same")
    assert_equal(12 , rd.age, "age not same")
    assert_equal("hubli" ,rd.address,"address not same")
  end
  
  
  def test_valid_file_write
    io = InputOutput.new
    rd = ResumeDetails.new("ernest",22,"dharwad")
    assert_nothing_raised() {io.write_to_file(rd)}
  end
  
  def test_invalid_file_write
    io = InputOutput.new
    rd = ResumeDetails.new("",0,"")
    rd1 = ResumeDetails.new("aditya",123,"")
    assert_raise(RuntimeError) {io.write_to_file(rd)}
    assert_raise(RuntimeError) {io.write_to_file(rd1)}
  end
  
  def test_empty_instance
    assert_raise(ArgumentError) {rd = ResumeDetails.new()}
  end
  
  def test_initalized_instance
    rd = ResumeDetails.new("ernest","22","dharwad")
    assert_equal("ernest",rd.name,"name is not as expected")
    assert_equal(22 , rd.age ,"age is not as expected")
    assert_equal("dharwad" , rd.address,"address is not as expected")
  end
  
  def test_wirte_to_file
    file_text = ""
    File.open("resume_details.txt") do|file|
      while line = file.gets
        file_text += line
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
