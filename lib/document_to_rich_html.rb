# frozen_string_literal: true

require_relative 'document_to_rich_html/version'
require_relative 'document_to_rich_html/docx_patch'
require 'docx'
require_relative 'document_to_rich_html/pdf_converter'
require_relative 'document_to_rich_html/word_converter'
require_relative 'document_to_rich_html/excel_converter'
require_relative 'document_to_rich_html/image_converter'
require_relative 'document_to_rich_html/html_formatter'
require_relative 'document_to_rich_html/security_utils'

# Converts documents to rich HTML format
module DocumentToRichHtml
  class Error < StandardError; end

  def self.convert(file_path)
    SecurityUtils.validate_file(file_path)
    extension = File.extname(file_path).downcase
    case extension
    when '.pdf'
      PdfConverter.convert(file_path)
    when '.docx', '.doc'
      WordConverter.convert(file_path)
    when '.xlsx', '.xls'
      ExcelConverter.convert(file_path)
    when '.jpg', '.jpeg', '.png', '.gif', '.svg'
      ImageConverter.convert(file_path)
    else
      raise Error, "Unsupported file format: #{extension}"
    end
  end
end
