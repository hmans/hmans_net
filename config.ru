require 'rubygems'
require 'bundler'
Bundler.require

require 'schreihals'

class MyBlog < Schreihals::App
  set :blog_title, "Hendrik Mans"
  set :blog_description, "Description and stuff."
  set :author_name, "Hendrik Mans"
  set :disqus_name, "hmans"
end

run MyBlog
