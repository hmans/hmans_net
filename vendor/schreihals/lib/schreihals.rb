require 'schreihals/version'
require 'sinatra'
require 'haml'
require 'sass'
require 'redcarpet'
require 'schnitzelstyle'
require 'document_mapper'
require 'rack-cache'
require 'coderay'
require 'rack/codehighlighter'

require 'active_support/core_ext/string/inflections'

module Schreihals
  class Post
    include DocumentMapper::Document

    def read_yaml_with_defaults
      read_yaml_without_defaults
      self.attributes = {
        disqus: true,
        status: 'published'
      }.merge(attributes)
    end
    alias_method_chain :read_yaml, :defaults

    def to_url
      date.present? ? "/#{year}/#{month}/#{day}/#{slug}/" : "/#{slug}/"
    end

    def disqus_identifier
      attributes[:disqus_identifier] || file_name_without_extension
    end

    def disqus?
      disqus && published?
    end

    def published?
      status == 'published'
    end

    def post?
      date.present?
    end

    def page?
      !post?
    end

    # load all posts.
    self.directory = 'posts'
  end

  class App < Sinatra::Application
    set :blog_title, "My Schreihals Blog"
    set :author_name, "Author"
    set :disqus_name, nil

    use Rack::ShowExceptions
    use Rack::Cache
    use Rack::Static, :urls => ["/media"], :root => "public"
    use Rack::Codehighlighter, :coderay, :markdown => true, :element => "pre>code", :pattern => /\A:::(\w+)\s*\n/

    helpers do
      def partial(thing, locals = {})
        name = case thing
          when String then thing
          else thing.class.to_s.demodulize.underscore
        end

        haml :"partials/_#{name}", :locals => { name.to_sym => thing }.merge(locals)
      end

      def link_to(title, thing)
        url = thing.respond_to?(:to_url) ? thing.to_url : thing.to_s
        haml "%a{href: '#{url}'} #{title}"
      end

      def show_disqus?
        settings.disqus_name.present?
      end

      def production?
        settings.environment.to_sym == :production
      end
    end

    before do
      cache_control :public, :must_revalidate, :max_age => 60
    end

    get '/' do
      @posts = Post.order_by(:date => :desc)
      @posts = @posts.where(:status => 'published') if production?
      @posts = @posts.all
      haml :index
    end

    get '/schreihals.css' do
      scss :schreihals
    end

    get '/:year/:month/:day/:slug/?' do |year, month, day, slug|
      render_page(slug)
    end

    get '/:slug/?' do |slug|
      render_page(slug)
    end

    def render_page(slug)
      if @post = Post.where(:slug => slug).first
        haml :post
      else
        "not found :("
      end
    end
  end
end
