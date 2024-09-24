# frozen_string_literal: true

require 'roo'

module DocumentToRichHtml
  class ExcelConverter
    def self.convert(file_path)
      content = extract_content(file_path)
      HtmlFormatter.format(content)
    end

    def self.extract_content(file_path)
      spreadsheet = Roo::Spreadsheet.open(file_path)
      html = '<table>'
      spreadsheet.each_with_index do |row, index|
        html += index.zero? ? '<thead><tr>' : '<tr>'
        row.each_with_index do |cell, cell_index|
          cell_style = spreadsheet.font(index, cell_index)
          style = "style='"
          style += 'font-weight: bold;' if cell_style&.bold?
          style += 'font-style: italic;' if cell_style&.italic?
          style += 'text-decoration: underline;' if cell_style&.underline?
          style += "'"
          html += index.zero? ? "<th #{style}>#{cell}</th>" : "<td #{style}>#{cell}</td>"
        end
        html += index.zero? ? '</tr></thead><tbody>' : '</tr>'
      end
      html += '</tbody></table>'
      html
    end
  end
end
