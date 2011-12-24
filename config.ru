require 'rubygems'
require 'bundler'
Bundler.require

require 'schreihals'

class MyBlog < Schreihals::App
  set :blog_title, "Hendrik Mans"
  set :blog_description, "Hendrik Mans lebt in Hamburg und baut Sachen im Internet."
  set :author_name, "Hendrik Mans"
  set :disqus_name, "hmans"
end

run MyBlog
