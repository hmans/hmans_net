source 'https://rubygems.org'

gem 'rack-rewrite', '~> 1.2.1'

group :development do
  gem 'shotgun'
  gem 'heroku'
end

group :production do
  gem 'unicorn'
end

if ENV['DEV']
  # for local development:
  gem 'schnitzelstyle', :path => '../schnitzelstyle'
  gem 'schnitzelpress',     :path => '../schnitzelpress'
else
  # use development versions of our two gems.
  gem 'schnitzelstyle',  git: 'git://github.com/hmans/schnitzelstyle.git'
  gem 'schnitzelpress',      git: 'git://github.com/hmans/schnitzelpress.git'
end
