require 'ruby_task'
require 'test/unit'

class TestResume < Test::Unit::TestCase
  def test_empty_instance
    rd = ResumeDetails.new()
    assert_equal("" ,rd.name,"object instance variables must not be initalized")
    assert_equal(0, rd.age,"object instance variables must not be initalized ")
    asserf_equal("", ed.address,"object instance variables must not be initalized")
  end
  def test_initalized_instance
    rd = ResumeDetails.new("ernest","22","dharwad")
    assert_equal("ernest",rd.name,"name is not as expected")
    assert_equal(22 , rd.age ,"age is not as expected")
    assert_equal("dharwad" , rd.address,"address is not as expected")
  end
end

