require 'ruby_task'
require 'test/unit'

class TestResume < Test::Unit::TestCase
  def test_read_from_console
    pd = PersonDetails.new()
    entered_string = pd.read_from_console()
    assert_match(%r{[(\w).]+},entered_string,"the entered text is not a string")
  end
end
