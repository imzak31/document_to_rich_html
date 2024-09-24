# frozen_string_literal: true

require 'spec_helper'

RSpec.describe DocumentToRichHtml::ImageConverter do
  describe '.convert' do
    it 'converts image to base64-encoded HTML with Trix attributes' do
      jpg_path = create_temp_file("\xFF\xD8\xFF", '.jpg')
      allow(MIME::Types).to receive(:type_for).and_return([double(content_type: 'image/jpeg')])
      allow(File).to receive(:read).and_return('image_data')
      allow(File).to receive(:size).and_return(100)
      allow(File).to receive(:basename).and_return('test.jpg')

      result = described_class.convert(jpg_path)
      expect(result).to include('<img')
      expect(result).to include('data-trix-content-type="img"')
      expect(result).to include('data-trix-attachment=')
      expect(result).to include('data-trix-attributes=')
      expect(result).to include('image/jpeg')
      expect(result).to include('base64,aW1hZ2VfZGF0YQ==')
    end
  end
end
