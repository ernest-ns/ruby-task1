require 'ruby_task'
require 'test/unit'

class TestResume <Test::Unit::TestCase
  def test_wirte_to_file
    file_text = ""
    File.open("resume_details.txt") do|file|
      while line = file.gets
        file_text += line
      end
    end
    assert_not_equal(0 , file_text.size,"the file is empty")
  end
end
