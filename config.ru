require 'schreihals'

class MyBlog < Schreihals::App
  set :blog_title, "hmans.net"
  set :author_name, "Hendrik Mans"
end

# Serve static media assets from the public/media/ directory
#
use Rack::Static, :urls => ["/media"], :root => "public"

run MyBlog
