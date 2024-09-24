# frozen_string_literal: true

require 'spec_helper'

RSpec.describe DocumentToRichHtml do
  it 'has a version number' do
    expect(DocumentToRichHtml::VERSION).not_to be nil
  end

  describe '.convert' do
    before do
      allow(DocumentToRichHtml::SecurityUtils).to receive(:validate_file).and_return(true)
    end

    context 'with a PDF file' do
      it 'converts PDF to HTML' do
        pdf_path = create_temp_file('%PDF-1.5', '.pdf')
        expect(DocumentToRichHtml::PdfConverter).to receive(:convert).with(pdf_path)
        DocumentToRichHtml.convert(pdf_path)
      end
    end

    context 'with a Word file' do
      it 'converts DOCX to HTML' do
        docx_path = create_temp_file('PK', '.docx')
        expect(DocumentToRichHtml::WordConverter).to receive(:convert).with(docx_path)
        DocumentToRichHtml.convert(docx_path)
      end
    end

    context 'with an Excel file' do
      it 'converts XLSX to HTML' do
        xlsx_path = create_temp_file('PK', '.xlsx')
        expect(DocumentToRichHtml::ExcelConverter).to receive(:convert).with(xlsx_path)
        DocumentToRichHtml.convert(xlsx_path)
      end
    end

    context 'with an image file' do
      it 'converts JPG to HTML' do
        jpg_path = create_temp_file("\xFF\xD8\xFF", '.jpg')
        expect(DocumentToRichHtml::ImageConverter).to receive(:convert).with(jpg_path)
        DocumentToRichHtml.convert(jpg_path)
      end
    end

    context 'with an unsupported file type' do
      it 'raises an error' do
        txt_path = create_temp_file('Plain text', '.txt')
        expect do
          DocumentToRichHtml.convert(txt_path)
        end.to raise_error(DocumentToRichHtml::Error, /Unsupported file format/)
      end
    end
  end
end
