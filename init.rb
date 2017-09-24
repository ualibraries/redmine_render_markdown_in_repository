require 'redmine'
require_dependency 'markdown_in_repository/render'
require_dependency 'markdown_in_repository/repositories_controller_patch'

Rails.configuration.to_prepare do
  unless RepositoriesController.included_modules.include? MarkdownInRepository::RepositoriesControllerPatch
    RepositoriesController.send(:include, MarkdownInRepository::RepositoriesControllerPatch)
  end
end

Redmine::Plugin.register :redmine_render_markdown_in_repository do
  name 'Render Markdown in Repository Browser'
  author 'guenbakku (origin: Makoto Kawasaki)'
  author_url 'https://github.com/guenbakku/'
  description 'Render markdown file (.md or .markdown) in repository browser'
  version '1.0.3'
  url 'https://github.com/guenbakku/redmine_render_markdown_in_repository'
  requires_redmine :version_or_higher => '3.4'
end
