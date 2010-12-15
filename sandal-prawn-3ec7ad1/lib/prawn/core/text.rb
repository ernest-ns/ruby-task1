# encoding: utf-8

# prawn/core/text.rb : Implements low level text helpers for Prawn
#
# Copyright January 2010, Daniel Nelson.  All Rights Reserved.
#
# This is free software. Please see the LICENSE and COPYING files for details.

ruby_18 { $KCODE="U" }

module Prawn
  module Core
    module Text #:nodoc:

      # These should be used as a base. Extensions may build on this list
      #
      VALID_OPTIONS = [:kerning, :size, :style]
      MODES = { :fill => 0, :stroke => 1, :fill_stroke => 2, :invisible => 3,
                :fill_clip => 4, :stroke_clip => 5, :fill_stroke_clip => 6,
                :clip => 7 }

      attr_reader :skip_encoding

      # Low level text placement method. All font and size alterations
      # should already be set
      #
      def draw_text!(text, options)
        x,y = map_to_absolute(options[:at])
        add_text_content(text,x,y,options)
      end

      # Low level call to set the current font style and extract text options from
      # an options hash. Should be called from within a save_font block
      #
      def process_text_options(options)
        if options[:style]
          raise "Bad font family" unless font.family
          font(font.family, :style => options[:style])
        end

        # must compare against false to keep kerning on as default
        unless options[:kerning] == false
          options[:kerning] = font.has_kerning_data?
        end

        options[:size] ||= font_size
      end

      # Document wide setting of whether or not to use kerning with text
      # Defaults to true
      # Can be overridden using the :kerning text option
      #
      def default_kerning?
        return true if @default_kerning.nil?
        @default_kerning
      end

      def default_kerning(boolean)
        @default_kerning = boolean
      end

      alias_method :default_kerning=, :default_kerning

      # Document wide setting of leading
      # Defaults to 0
      # Can be overridden using the :leading text option
      #
      def default_leading?
        return 0 if @default_leading.nil?
        @default_leading
      end

      def default_leading(number)
        @default_leading = number
      end

      alias_method :default_leading=, :default_leading

      # Call with no argument to retrieve the current text rendering mode.
      #
      # Call with a symbol and block to temporarily change the current
      # text rendering mode.
      #
      #   pdf.text_rendering_mode(:stroke) do
      #     pdf.text("Outlined Text")
      #   end
      #
      # Valid modes are:
      #
      # * :fill             - fill text (default)
      # * :stroke           - stroke text
      # * :fill_stroke      - fill, then stroke text
      # * :invisible        - invisible text
      # * :fill_clip        - fill text then add to path for clipping
      # * :stroke_clip      - stroke text then add to path for clipping
      # * :fill_stroke_clip - fill then stroke text, then add to path for clipping
      # * :clip             - add text to path for clipping
      #
      def text_rendering_mode(mode=nil)
        return @text_rendering_mode || :fill if mode.nil?
        unless MODES.keys.include?(mode)
          raise ArgumentError, "mode must be between one of #{MODES.keys.join(', ')} (#{mode})"
        end
        original_mode = text_rendering_mode
        if original_mode == mode
          yield
        else
          @text_rendering_mode = mode
          add_content "\n#{MODES[mode]} Tr"
          yield
          add_content "\n#{MODES[original_mode]} Tr"
          @text_rendering_mode = original_mode
        end
      end

      # Increases or decreases the space between characters.
      # For horizontal text, a positive value will increase the space.
      # For veritical text, a positive value will decrease the space.
      #
      def character_spacing(amount=nil)
        return @character_spacing || 0 if amount.nil?
        original_character_spacing = character_spacing
        if original_character_spacing == amount
          yield
        else
          @character_spacing = amount
          add_content "\n%.3f Tc" % amount
          yield
          add_content "\n%.3f Tc" % original_character_spacing
          @character_spacing = original_character_spacing
        end
      end

      # Increases or decreases the space between words.
      # For horizontal text, a positive value will increase the space.
      # For veritical text, a positive value will decrease the space.
      #
      def word_spacing(amount=nil)
        return @word_spacing || 0 if amount.nil?
        original_word_spacing = word_spacing
        if original_word_spacing == amount
          yield
        else
          @word_spacing = amount
          add_content "\n%.3f Tw" % amount
          yield
          add_content "\n%.3f Tw" % original_word_spacing
          @word_spacing = original_word_spacing
        end
      end

      private

      def add_text_content(text, x, y, options)
        chunks = font.encode_text(text,options)

        add_content "\nBT"

        if options[:rotate]
          rad = options[:rotate].to_f * Math::PI / 180
          arr = [ Math.cos(rad), Math.sin(rad), -Math.sin(rad), Math.cos(rad), x, y ]
          add_content "%.3f %.3f %.3f %.3f %.3f %.3f Tm" % arr
        else
          add_content "#{x} #{y} Td"
        end

        chunks.each do |(subset, string)|
          font.add_to_current_page(subset)
          add_content "/#{font.identifier_for(subset)} #{font_size} Tf"

          operation = options[:kerning] && string.is_a?(Array) ? "TJ" : "Tj"
          add_content Prawn::Core::PdfObject(string, true) << " " << operation
        end

        add_content "ET\n"
      end
    end

  end
end
