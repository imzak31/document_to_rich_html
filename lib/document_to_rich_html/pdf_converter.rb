# frozen_string_literal: true

require 'pdf-reader'

module DocumentToRichHtml
  class PdfConverter
    def self.convert(file_path)
      content = extract_content(file_path)
      HtmlFormatter.format(content)
    end

    def self.extract_content(file_path)
      reader = PDF::Reader.new(file_path)
      html = ''
      reader.pages.each do |page|
        html += "<div class='pdf-page'>"
        html += page.text.split("\n").map { |line| "<p>#{line}</p>" }.join
        html += '</div>'
      end
      html
    end
  end
end
