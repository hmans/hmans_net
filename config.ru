require 'rubygems'
require 'bundler'
Bundler.require

require 'schreihals'

class MyBlog < Schreihals::App
  set :blog_title, "Hendrik Mans"
  set :blog_description, "Hendrik Mans lebt in Hamburg und baut Sachen im Internet &bull; [Impressum](/impressum)"
  set :author_name, "Hendrik Mans"
  set :disqus_name, "hmans"
  set :google_analytics_id, "UA-7555710-4"
end

run MyBlog
