# frozen_string_literal: true

require 'spec_helper'

RSpec.describe DocumentToRichHtml::WordConverter do
  describe '.convert' do
    it 'converts DOCX content to HTML' do
      docx_path = create_temp_file('PK', '.docx')
      mock_doc = double('Docx::Document')
      mock_paragraph = double('Docx::Paragraph')

      allow(Docx::Document).to receive(:open).and_return(mock_doc)
      allow(mock_doc).to receive(:paragraphs).and_return([mock_paragraph])
      allow(mock_paragraph).to receive(:to_html).and_return('Word content')

      result = described_class.convert(docx_path)
      expect(result).to include('<div class="word-document">')
      expect(result).to include('<p data-trix-content-type="p">Word content</p>')
    end
  end
end
