require 'asciidoctor-pdf' unless defined? ::Asciidoctor::Pdf

module AsciidoctorPdfSectionExtensions
# from https://github.com/asciidoctor/asciidoctor-pdf/blob/main/lib/asciidoctor/pdf/ext/asciidoctor/section.rb
  def numbered_title opts = {}
    @cached_numbered_title ||= nil
    unless @cached_numbered_title
      doc = @document
      if @numbered && !@caption && (slevel = @level) <= (doc.attr 'sectnumlevels', 3).to_i
        @is_numbered = true
        if doc.doctype == 'book'
          case slevel
          when 0
            @cached_numbered_title = %(#{sectnum nil, ':'} #{title})
            signifier = doc.attributes['part-signifier'] || ((doc.attr_unspecified? 'part-signifier') ? 'Part' : '')
            @cached_formal_numbered_title = %(#{signifier}#{signifier.empty? ? '' : ' '}#{@cached_numbered_title})
          when 1
            @cached_numbered_title = %(#{sectnum '.', ' 章'} #{title})
            signifier = doc.attributes['chapter-signifier'] || ((doc.attr_unspecified? 'chapter-signifier') ? '第' : '')
            @cached_formal_numbered_title = %(#{signifier}#{signifier.empty? ? '' : ' '}#{@cached_numbered_title})
          else
            @cached_formal_numbered_title = @cached_numbered_title = %(#{sectnum} #{title})
          end
        else
          @cached_formal_numbered_title = @cached_numbered_title = %(#{sectnum} #{title})
        end
      elsif @level == 0
        @is_numbered = false
        @cached_numbered_title = @cached_formal_numbered_title = title
      else
        @is_numbered = false
        @cached_numbered_title = @cached_formal_numbered_title = captioned_title
      end
    end
    opts[:formal] ? @cached_formal_numbered_title : @cached_numbered_title
  end
end

Asciidoctor::Section.prepend AsciidoctorPdfSectionExtensions
