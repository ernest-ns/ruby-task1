require 'ruby_task'
require 'test/unit'

class TestResume < Test::Unit::TestCase
  def test_write_to_file
    io = InputOutput.new
    rd = ResumeDetails.new("ernest",22,"dharwad")
    rd1 = ResumeDetails.new("",0,"")
    assert_raise(RuntimeError) {io.write_to_file(rd1)}
    assert_nothing_raised() {io.write_to_file(rd)}
  end
end

