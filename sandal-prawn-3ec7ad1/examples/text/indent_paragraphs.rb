# encoding: utf-8
#
# Example of two ways of indenting paragraphs
#
#
require File.expand_path(File.join(File.dirname(__FILE__),
                                   %w[.. example_helper]))

Prawn::Document.generate "indent_paragraphs.pdf" do |pdf|
  hello = "hello " * 50
  world = "world " * 50
  pdf.text(hello + "\n" + world, :indent_paragraphs => 60)

  pdf.move_cursor_to(pdf.font.height)
  pdf.text(hello + "\n" + world, :indent_paragraphs => 60)

  pdf.move_cursor_to(pdf.font.height * 3)
  pdf.text(hello + "\n" + world, :indent_paragraphs => 60)

  # can also indent using a non-breaking space
  nbsp = Prawn::Text::NBSP
  pdf.text("\n" * 10 + hello + "\n#{nbsp * 10}" + world)
end
