require 'rubygems'
require 'bundler'
Bundler.require

require 'schreihals'
require 'rack/rewrite'

class MyBlog < Schreihals::App
  set :blog_title, "Hendrik Mans"
  set :blog_url, "http://hmans.net"
  set :blog_description, "...lebt in Hamburg und baut Sachen im Internet."
  set :footer, "[Impressum](/impressum) &middot; läuft auf [Schreihals](http://schreihals.info)"
  set :author_name, "Hendrik Mans"
  set :disqus_name, "hmans"
  set :google_analytics_id, "UA-7555710-4"
  set :gauges_id, "4f0570ea613f5d5351000001"
  set :twitter_id, 'hmans'
  set :read_more, "Kompletten Artikel lesen"

  # set :documents_store, :dropbox
  # set :documents_source, 'http://publicbox.heroku.com/s/timd27onyt5t5b6'
  # set :documents_cache, Dalli::Client.new

  # I'm redirecting my /rss URL because it's still getting heaps of hits
  # from the Tumblr days.
  #
  get '/rss' do
    redirect '/atom.xml'
  end
end

use Rack::Rewrite do
  if ENV['RACK_ENV'] == 'production'
    r301 %r{.*}, 'http://hendrik.mans.de$&', :if => Proc.new { |env|
      env['SERVER_NAME'] != 'hendrik.mans.de'
    }
  end
end


run MyBlog
