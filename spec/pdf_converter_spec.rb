# frozen_string_literal: true

require 'spec_helper'

RSpec.describe DocumentToRichHtml::PdfConverter do
  describe '.convert' do
    it 'extracts text content from PDF and formats it as HTML' do
      pdf_path = create_temp_file('%PDF-1.5', '.pdf')
      allow(PDF::Reader).to receive(:new).and_return(double(pages: [double(text: "Page 1\nContent")]))

      result = described_class.convert(pdf_path)
      expect(result).to include('<div class="pdf-page">')
      expect(result).to include('<p data-trix-content-type="p">Page 1</p>')
      expect(result).to include('<p data-trix-content-type="p">Content</p>')
    end
  end
end
