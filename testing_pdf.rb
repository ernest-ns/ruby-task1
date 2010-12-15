require 'rubygems'
require 'pdf/toolkit'
require 'pdf/writer'

text = "This is a sample text"
my_file = PDF::Writer.new()
my_file.text(text)
my_stream = my_file.render()
File.open("resume_det.pdf", "a") do |file|
  file.puts my_stream
end

