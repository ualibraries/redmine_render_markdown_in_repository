require 'markdown/render'

Redmine::Plugin.register :redmine_render_markdown_in_repository do
  name 'Render Markdown in Repository'
  author 'Makoto Kawasaki'
  description 'This plugin renders markdown file in repository'
  version '0.0.1'
  url 'https://github.com/makotokw/redmine_render_markdown_in_repository'
  author_url 'http://makotokw.com'
end

MARKDOWN_EXTS = %w{md markdown}.freeze
MARKDOWN_EXTS.each do |ext|
  Redmine::MimeType::EXTENSIONS[ext] = 'text/x-markdown'
end

RepositoriesController.class_eval do
  alias redmine_render_markdown_in_repository_orig_entry entry
  def entry
    redmine_render_markdown_in_repository_orig_entry
    if !performed? && @path =~ /\.(?:#{MARKDOWN_EXTS.join('|')})$/i
      markdown = Redcarpet::Markdown.new(MarkdownRender,
                                         :tables => true, :fenced_code_blocks => true,
                                         :autolink => true, :space_after_headers => true)
      @content = markdown.render(@content)
      render :action => 'entry_markdown'
    end
  end
end
