# encoding: UTF-8
require 'rubygems'
require 'bundler'
Bundler.require

$stdout.sync = true

use Rack::Rewrite do
  # Enforce canonical hendrik.mans.de URL
  #
  if Schnitzelpress.env.production?
    r301 %r{.*}, 'http://hendrik.mans.de$&', :if => Proc.new { |env|
      env['SERVER_NAME'] != 'hendrik.mans.de'
    }
  end

  # Redirect deprecated feed URLs
  #
  r301 '/rss', '/feed'
  r301 '/atom.xml', '/feed'
end

run Schnitzelpress.omnomnom!
