# frozen_string_literal: true

require 'spec_helper'

RSpec.describe DocumentToRichHtml::HtmlFormatter do
  describe '.format' do
    it 'sanitizes HTML and adds Trix-specific attributes' do
      input_html = '<p>Test</p><img src="data:image/png;base64,abc123">'
      result = described_class.format(input_html)

      expect(result).to include('data-trix-content-type="p"')
      expect(result).to include('data-trix-attachment=')
      expect(result).to include('data-trix-attributes=')
      expect(result).not_to include('src=')
      expect(result).to include('data-trix-content-type="img"')
    end
  end
end
