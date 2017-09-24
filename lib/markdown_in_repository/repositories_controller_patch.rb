require_dependency 'repositories_controller'

module MarkdownInRepository

  module RepositoriesControllerPatch

    def self.included(base)
      base.send(:include, InstanceMethod)
      base.class_eval do
        unloadable
        alias_method_chain :entry, :markdown
      end
    end

    module InstanceMethod
      def entry_with_markdown
        entry_without_markdown
        if !performed? && @path =~ /\.(?:#{MARKDOWN_EXTS.join('|')})$/i
          raw_url = request.protocol + request.host + [
            '/projects', params[:id], 'repository',
            'revisions', @rev, 'raw', URI.encode(@path)
          ].join('/')

          mkrender = MarkdownInRepository::MarkdownRender.new
          mkrender.set_raw_url(raw_url)
          markdown = Redcarpet::Markdown.new(
              mkrender,
              :autolink => true,
              :fenced_code_blocks => true,
              :space_after_headers => true,
              :tables => true,
              :strikethrough => true,
              :superscript => true,
              :no_intra_emphasis => true
          )
          @content = markdown.render(@content)
          render :action => 'entry_markdown'
        end
      end
    end
  end
end


