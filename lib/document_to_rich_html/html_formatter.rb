# frozen_string_literal: true

require 'nokogiri'
require 'sanitize'
require 'json'

module DocumentToRichHtml
  class HtmlFormatter
    SANITIZER_CONFIG = Sanitize::Config.merge(Sanitize::Config::RELAXED,
      attributes: Sanitize::Config::RELAXED[:attributes].merge(
        'img' => ['data-trix-attachment', 'data-trix-attributes'],
        :all => (Sanitize::Config::RELAXED[:attributes][:all] || []) + ['data-trix-content-type']
      )
      # Note: No need to specify protocols for 'img' 'src' since 'src' is not allowed
    )

    def self.format(content)
      doc = Nokogiri::HTML.fragment(content)

      # Process images before sanitization
      doc.css('img').each do |img|
        next if img['src'].nil? || !img['src'].start_with?('data:')

        # Ensure data-trix-attachment is preserved
        unless img['data-trix-attachment']
          content_type = img['src'][/^data:(.*?);/, 1] || 'application/octet-stream'
          extension = content_type.split('/')[1] || 'bin'

          img['data-trix-attachment'] = {
            contentType: content_type,
            filename: "image.#{extension}",
            filesize: img['src'].length,
            height: 'auto',
            width: 'auto',
            url: img['src']
          }.to_json
        end

        # Ensure data-trix-attributes is preserved
        img['data-trix-attributes'] ||= '{"presentation":"gallery"}'
      end

      # Sanitize the HTML to prevent XSS attacks
      sanitized_html = Sanitize.fragment(doc.to_html, SANITIZER_CONFIG)

      # Re-parse the sanitized HTML
      doc = Nokogiri::HTML.fragment(sanitized_html)

      # Add data-trix-content-type attributes
      doc.css('p, h1, h2, h3, h4, h5, h6, ul, ol, blockquote, pre, table, tr, td, th, img')
         .each { |node| node['data-trix-content-type'] = node.name }

      doc.to_html
    end
  end
end
