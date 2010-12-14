require 'ruby_task'
require 'test/unit'

class TestResume < Test::Unit::TestCase
  def test_write_to_file
    io = InputOutput.new
    rd = ResumeDetails.new("ernest",22,"dharwad")
    rd1 = ResumeDetails.new("",0,"")
    assert_raise(RuntimeError) {io.write_to_file(rd1.name,rd1.age , rd1.address)}
    assert_nothing_raised() {io.write_to_file(rd.name, rd.age, rd.address)}
    assert_raise(Runtimeerror) {io.write_to_file("",0,"")}
  end
end

