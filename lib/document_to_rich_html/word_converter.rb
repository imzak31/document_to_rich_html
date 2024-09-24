# frozen_string_literal: true

require 'docx'

module DocumentToRichHtml
  class WordConverter
    def self.convert(file_path)
      content = extract_content(file_path)
      HtmlFormatter.format(content)
    end

    def self.extract_content(file_path)
      doc = Docx::Document.open(file_path)
      html = '<div class="word-document">'
      doc.paragraphs.each do |paragraph|
        html += "<p>#{paragraph.to_html}</p>"
      end
      html += '</div>'
      html
    end
  end
end
