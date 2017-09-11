require 'redcarpet'
require 'coderay'

module MarkdownInRepository

  MARKDOWN_EXTS = %w{md markdown}.freeze
  MARKDOWN_EXTS.each do |ext|
    Redmine::MimeType::EXTENSIONS[ext] = 'text/x-markdown'
  end

  class MarkdownRender < Redmine::WikiFormatting::Markdown::HTML; end
end