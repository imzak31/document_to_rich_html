# frozen_string_literal: true

require 'base64'
require 'mime/types'

module DocumentToRichHtml
  class ImageConverter
    def self.convert(file_path)
      content = extract_content(file_path)
      HtmlFormatter.format(content)
    end

    def self.extract_content(file_path)
      mime_type = MIME::Types.type_for(file_path).first.content_type
      base64_image = Base64.strict_encode64(File.read(file_path))
      file_name = File.basename(file_path)
      file_size = File.size(file_path)
      
      "<img src='data:#{mime_type};base64,#{base64_image}' alt='Embedded Image' data-trix-attachment='{\"contentType\":\"#{mime_type}\",\"filename\":\"#{file_name}\",\"filesize\":#{file_size},\"height\":auto,\"width\":auto,\"url\":\"data:#{mime_type};base64,#{base64_image}\"}' data-trix-attributes='{\"presentation\":\"gallery\"}'>"
    end
  end
end
