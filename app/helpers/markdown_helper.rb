module MarkdownHelper
  class HTMLwithCodeRay < Redcarpet::Render::HTML
    def block_code(code, language)
      lang = language.presence || "md"
      CodeRay.scan(code, lang).div
    end
  end

  def markdown(text)
    options = {
      filter_html: true,
      hard_wrap: true,
    }
    extensions = {
      no_intra_emphasis: true,
      tables: true,
      fenced_code_blocks: true,
      autolink: true,
      strikethrough: true,
      lax_spacing: true,
      space_after_headers: true,
    }
    renderer = HTMLwithCodeRay.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)
    markdown.render(text).html_safe # rubocop:disable Rails/OutputSafety
  end
end
