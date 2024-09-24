require 'docx'

module DocumentToRichHtml
  module DocxPatch
    def self.apply
      unless Docx.const_defined?(:ElementPatch)
        Docx.const_set(:ElementPatch, Module.new)
      end

      unless Docx::ElementPatch.const_defined?(:Element)
        Docx::ElementPatch.const_set(:Element, Class.new)
      end
    end
  end
end

DocumentToRichHtml::DocxPatch.apply
