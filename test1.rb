require 'ruby_task'
require 'test/unit'

class TestResume < Test::Unit::TestCase
  def test_read_from_console
    io = InputOutput.new()
    dummy_console = File.new("testfile")
    entered_string = io.read_from_console(dummy_console)
    assert_match(%r{[(\w).]+},entered_string,"the entered text is not a string")
  end
end
