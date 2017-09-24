module MarkdownInRepository

  MARKDOWN_EXTS = %w{md markdown}.freeze
  MARKDOWN_EXTS.each do |ext|
    Redmine::MimeType::EXTENSIONS[ext] = 'text/x-markdown'
  end

  class MarkdownRender < Redmine::WikiFormatting::Markdown::HTML
    @@raw_url = nil

    def image(link, title, alt_text)
      return unless uri_with_safe_scheme?(link)

      unless link.starts_with?('/')
        link = URI.join(@@raw_url, URI.encode(link))
      end
      tag('img', :src => link, :alt => alt_text || "", :title => title)
    end

    def set_raw_url(raw_url)
      @@raw_url = raw_url
    end
  end
end