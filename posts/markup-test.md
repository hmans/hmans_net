---
title: Schreihals Markup test
disqus: true
---

Excepteur duis boudin dolor, short loin pork chop tail in quis chuck strip steak proident kielbasa corned beef. Reprehenderit duis sausage, dolore aliquip irure in filet mignon turkey. In laboris sint cupidatat pork loin esse.

> Bacon ipsum dolor sit amet ullamco leberkäse eiusmod consectetur, in pork jowl brisket pancetta. Dolore cupidatat chuck ullamco, pork loin swine filet mignon pork belly qui. Shank aliquip enim, fugiat filet mignon esse pariatur commodo. Venison pork chop tenderloin, in nulla ground round tri-tip chuck in id brisket nisi pork loin nostrud. Short ribs magna sunt, cillum officia dolore pork chop ullamco laboris andouille sint nulla velit laborum. Pariatur consectetur ham, turducken sunt do veniam eu t-bone hamburger short loin laboris elit et. Aliquip ham hock turducken pariatur.

Consequat short loin short ribs, corned beef enim frankfurter sint do ground round quis rump venison magna. Meatloaf ball tip andouille spare ribs. Officia boudin laborum, duis pancetta ut dolore consequat. Consectetur quis adipisicing, andouille minim flank jerky short loin shank hamburger cow. Jerky eu rump incididunt officia adipisicing. Nulla proident laboris adipisicing veniam, salami venison culpa. Beef ribs pork chop meatloaf, est dolore corned beef culpa ex sint reprehenderit andouille frankfurter labore.

### Ordered Lists

* Here's an item.
* Here's another item.
* Excepteur duis boudin dolor, short loin pork chop tail in quis chuck strip steak proident kielbasa corned beef. Reprehenderit duis sausage, dolore aliquip irure in filet mignon turkey. In laboris sint cupidatat pork loin esse.
* Yo.

### Unordered Lists

1. Here's an item.
2. Here's another item.
3. Excepteur duis boudin dolor, short loin pork chop tail in quis chuck strip steak proident kielbasa corned beef. Reprehenderit duis sausage, dolore aliquip irure in filet mignon turkey. In laboris sint cupidatat pork loin esse.
4. Yo.

### Images

![Skyrim!](http://almanach.scharesoft.de/images/d/df/Skyrim_Screenshot_Mammut.jpg)

### Code Blocks

This is a test!

    :::ruby
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

How about some XML?

    :::xml
    <!-- file: sample.xml -->
    <?xml version="1.0"?>

    <!-- our XML-document describes a purchase order -->
    <purchase-order>

      <date>2005-10-31</date>
      <number>12345</number>

      <purchased-by>
        <name>My name</name>
        <address>My address</address>
      </purchased-by>

      <!-- a collection element, contains a set of items -->
      <order-items>

        <item>
          <code>687</code>
          <type>CD</type>
          <label>Some music</label>
        </item>

        <item>
          <code>129851</code>
          <type>DVD</type>
          <label>Some video</label>
        </item>

      </order-items>

    </purchase-order>
