# frozen_string_literal: true

require_relative 'lib/document_to_rich_html/version'

Gem::Specification.new do |spec|
  spec.name          = 'document_to_rich_html'
  spec.version       = DocumentToRichHtml::VERSION
  spec.authors       = ['Adrián Centeno']
  spec.email         = ['adriandenb@gmail.com']

  spec.summary       = 'Convert various document formats to rich HTML'
  spec.description   = 'A gem to convert PDF, Word, Excel, and image files to rich HTML format compatible with Trix editor'
  spec.homepage      = 'https://github.com/imzak31/document_to_rich_html'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.5.0')

  spec.metadata['allowed_push_host'] = 'https://rubygems.org'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/imzak31/document_to_rich_html'
  spec.metadata['changelog_uri'] = 'https://github.com/imzak31/document_to_rich_html/blob/master/CHANGELOG.md'

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = ['document_to_rich_html']
  spec.require_paths = ['lib']

  spec.add_dependency 'docx'
  spec.add_dependency 'mime-types'
  spec.add_dependency 'nokogiri'
  spec.add_dependency 'pdf-reader'
  spec.add_dependency 'roo'
  spec.add_dependency 'sanitize'

  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
end
