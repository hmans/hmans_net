# encoding: UTF-8
require 'rubygems'
require 'bundler'
Bundler.require

Schreihals.mongo_uri =
    ENV['MONGOLAB_URI'] ||
    ENV['MONGOHQ_URL'] ||
    ENV['MONGO_URL'] ||
    'mongodb://localhost/hmans_net'

class App < Schreihals::App
  configure do
    set :blog_title, "Hendrik Mans"
    set :blog_description, "...lebt in Hamburg und baut Sachen im Internet."
    set :footer, "[Impressum](/impressum) &middot; läuft auf [Schreihals](http://schreihals.info)"
    set :author_name, "Hendrik Mans"
    set :disqus_name, "hmans"
    # set :google_analytics_id, "UA-7555710-4"
    set :gauges_id, "4f0570ea613f5d5351000001"
    set :twitter_id, 'hmans'
    set :read_more, "Kompletten Artikel lesen"
    set :administrator, "browser_id:hendrik@mans.de"
    set :feed_url, 'http://feeds.feedburner.com/hmans_de'
  end

  # I'm redirecting my /rss URL because it's still getting heaps of hits
  # from the Tumblr days.
  #
  get '/rss' do
    redirect '/feed'
  end

  # redirect old atom.xml URL, too
  get '/atom.xml' do
    redirect '/feed'
  end
end
