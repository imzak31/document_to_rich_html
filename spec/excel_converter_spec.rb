# frozen_string_literal: true

require 'spec_helper'

RSpec.describe DocumentToRichHtml::ExcelConverter do
  describe '.convert' do
    it 'converts Excel content to HTML table' do
      xlsx_path = create_temp_file('PK', '.xlsx')
      mock_spreadsheet = double('Spreadsheet')
      allow(Roo::Spreadsheet).to receive(:open).and_return(mock_spreadsheet)
      allow(mock_spreadsheet).to receive(:each_with_index).and_yield(['Header'], 0).and_yield(['Data'], 1)
      allow(mock_spreadsheet).to receive(:font).and_return(nil)

      result = described_class.convert(xlsx_path)
      expect(result).to include('<table data-trix-content-type="table">')
      expect(result).to include('<th data-trix-content-type="th">Header</th>')
      expect(result).to include('<td data-trix-content-type="td">Data</td>')
    end
  end
end
