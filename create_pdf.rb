begin 
 require 'pdf/writer'
rescue LoadError => le
if le.message =~ %r{pdf/writer$}
$LOAD_PATH.unshift("../lib")
require 'pdf/writer'
else
raise
end
end

pdf = PDF::Writer.new
pdf.text ""
pdf.save_as("resume_details.pdf")
