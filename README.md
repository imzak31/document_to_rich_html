# DocumentToRichHtml

DocumentToRichHtml is a powerful Ruby gem that converts various document formats (PDF, Word, Excel, and images) to rich HTML format compatible with the Trix editor. It preserves formatting, styles, and embedded images, making it ideal for applications that need to import and display formatted content.

## Features

- Converts PDF files to rich HTML, preserving text content
- Converts Word documents (.docx, .doc) to rich HTML, maintaining formatting and embedded images
- Converts Excel spreadsheets (.xlsx, .xls) to HTML tables
- Converts images (.jpg, .jpeg, .png, .gif, .svg) to embedded base64 data in HTML
- Formats output HTML to be compatible with Trix editor
- Implements security measures to prevent processing of malicious files

The `convert` method returns a string containing the rich HTML representation of the document, which can be used directly with the Trix editor or other rich text editors.

## Supported Formats and Capabilities

### PDF (.pdf)
- Extracts text content from all pages
- Preserves line breaks and basic structure

### Word (.docx, .doc)
- Preserves text formatting (bold, italic, underline, etc.)
- Maintains document structure (headings, paragraphs, lists)
- Retains embedded images
- Converts tables to HTML tables

### Excel (.xlsx, .xls)
- Converts spreadsheets to HTML tables
- Preserves cell values and basic formatting

### Images (.jpg, .jpeg, .png, .gif, .svg)
- Embeds images as base64-encoded data within the HTML
- Preserves image quality and dimensions

## Security Features

- File type validation using MIME type checking
- File size limits to prevent processing of extremely large files
- Secure temporary file handling
- Input sanitization to prevent XSS attacks

## Configuration

You can configure the maximum file size limit by setting an environment variable:

```bash
export MAX_FILE_SIZE=10000000
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'document_to_rich_html'
```

And then execute:

```bash
bundle install
```

``` or install it yourself as:

```bash
gem install document_to_rich_html
```

## Usage

```ruby
require 'document_to_rich_html'

html = DocumentToRichHtml.convert('path/to/your/document.pdf')
puts html

Convert a PDF file
rich_html = DocumentToRichHtml.convert('path/to/your/document.pdf')

Convert a Word document
rich_html = DocumentToRichHtml.convert('path/to/your/document.docx')

Convert an Excel spreadsheet
rich_html = DocumentToRichHtml.convert('path/to/your/spreadsheet.xlsx')

Convert an image
rich_html = DocumentToRichHtml.convert('path/to/your/image.jpg')
```

The `convert` method returns a string containing the rich HTML representation of the document, which can be used directly with the Trix editor or other rich text editors.

## Supported Formats and Capabilities

### PDF (.pdf)
- Extracts text content from all pages
- Preserves line breaks and basic structure

### Word (.docx, .doc)
- Preserves text formatting (bold, italic, underline, etc.)
- Maintains document structure (headings, paragraphs, lists)
- Retains embedded images
- Converts tables to HTML tables

### Excel (.xlsx, .xls)
- Converts spreadsheets to HTML tables
- Preserves cell values and basic formatting

### Images (.jpg, .jpeg, .png, .gif, .svg)
- Embeds images as base64-encoded data within the HTML
- Preserves image quality and dimensions

## Security Features

- File type validation using MIME type checking
- File size limits to prevent processing of extremely large files
- Secure temporary file handling
- Input sanitization to prevent XSS attacks


## Limitations

- PDF conversion is limited to text content; complex layouts or embedded images in PDFs are not preserved
- Some advanced formatting in Word documents may not be perfectly converted
- Excel conversion is basic and doesn't support advanced features like formulas or charts

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/imzak31/document_to_rich_html. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the DocumentToRichHtml project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/yourusername/document_to_rich_html/blob/master/CODE_OF_CONDUCT.md).
