$stdout.sync = true
require File.expand_path("../app.rb", __FILE__)
require 'rack/rewrite'

# Enforce canonical hendrik.mans.de URL
#
use Rack::Rewrite do
  if ENV['RACK_ENV'] == 'production'
    r301 %r{.*}, 'http://hendrik.mans.de$&', :if => Proc.new { |env|
      env['SERVER_NAME'] != 'hendrik.mans.de'
    }
  end
end

if Schnitzelpress.env.production?
  use Rack::Cache, {
    :verbose     => true,
    :metastore   => URI.encode("file:/tmp/cache/meta"),
    :entitystore => URI.encode("file:/tmp/cache/body")
  }
end

run App.with_local_files
