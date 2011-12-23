require 'schreihals/version'
require 'sinatra'
require 'haml'
require 'sass'
require 'redcarpet'
require 'schnitzelstyle'
require 'document_mapper'
require 'rack-cache'

require 'active_support/core_ext/string/inflections'

module Schreihals
  class Post
    include DocumentMapper::Document
    self.directory = 'posts'

    def to_url
      "/#{year}/#{month}/#{day}/#{slug}/"
    end
  end

  class App < Sinatra::Application
    set :blog_title, "My Schreihals Blog"
    set :author_name, "Author"
    set :disqus_name, nil

    use Rack::Cache
    use Rack::Static, :urls => ["/media"], :root => "public"

    helpers do
      def partial(thing, options = {})
        name = case thing
          when String then thing
          else thing.class.to_s.demodulize.underscore
        end
        haml :"partials/_#{name}", :locals => { name.to_sym => thing }
      end

      def link_to(title, thing)
        url = thing.respond_to?(:to_url) ? thing.to_url : thing.to_s
        haml "%a{href: '#{url}'} #{title}"
      end

      def show_disqus?
        settings.disqus_name.present?
      end
    end

    before do
      cache_control :public, :must_revalidate, :max_age => 60
    end

    get '/' do
      @posts = Post.order_by(:date => :desc).all
      haml :index
    end

    get '/:year/:month/:day/:slug/?' do |year, month, day, slug|
      if @post = Post.where(:slug => slug).first
        haml :post
      else
        "not found :("
      end
    end

    get '/schreihals.css' do
      scss :schreihals
    end
  end
end
