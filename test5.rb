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
end

