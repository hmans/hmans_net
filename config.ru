require 'rubygems'
require 'bundler'
Bundler.require

require 'schreihals'

class MyBlog < Schreihals::App
  set :blog_title, "Hendrik Mans"
  set :blog_url, "http://hmans.net"
  set :blog_description, "...lebt in Hamburg und baut Sachen im Internet."
  set :footer, "[Impressum](/impressum)"
  set :author_name, "Hendrik Mans"
  set :disqus_name, "hmans"
  set :google_analytics_id, "UA-7555710-4"
  set :read_more, "Kompletten Artikel lesen"

  # set :documents_store, :dropbox
  # set :documents_source, 'http://publicbox.heroku.com/s/timd27onyt5t5b6'
end

run MyBlog
