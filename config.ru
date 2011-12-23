require 'rubygems'
require 'bundler'
Bundler.require

require 'schreihals'

class MyBlog < Schreihals::App
  set :blog_title, "hmans.net"
  set :author_name, "Hendrik Mans"
end

run MyBlog
