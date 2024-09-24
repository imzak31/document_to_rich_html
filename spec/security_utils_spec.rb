# frozen_string_literal: true

require 'spec_helper'

RSpec.describe DocumentToRichHtml::SecurityUtils do
  describe '.validate_file' do
    it 'raises an error for non-existent files' do
      expect do
        described_class.validate_file('non_existent.pdf')
      end.to raise_error(DocumentToRichHtml::Error, /File not found/)
    end

    it 'raises an error for files exceeding the size limit' do
      allow(File).to receive(:exist?).and_return(true)
      allow(File).to receive(:size).and_return(described_class::MAX_FILE_SIZE + 1)
      expect do
        described_class.validate_file('large_file.pdf')
      end.to raise_error(DocumentToRichHtml::Error, /File too large/)
    end

    it 'raises an error for unsupported file types' do
      allow(File).to receive(:exist?).and_return(true)
      allow(File).to receive(:size).and_return(1000)
      allow(described_class).to receive(:`).and_return('application/octet-stream')
      expect do
        described_class.validate_file('unknown.bin')
      end.to raise_error(DocumentToRichHtml::Error, /Invalid file type/)
    end
  end
end
