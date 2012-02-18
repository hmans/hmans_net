source 'https://rubygems.org'

gem 'rack-rewrite', '~> 1.2.1'

group :development do
  gem 'shotgun'
  gem 'heroku'
end

if ENV['DEV']
  # for local development:
  gem 'schnitzelstyle', :path => '../schnitzelstyle'
  gem 'schreihals',     :path => '../schreihals'
else
  # use development versions of our two gems.
  gem 'schnitzelstyle',  git: 'git://github.com/hmans/schnitzelstyle.git'
  gem 'schreihals',      git: 'git://github.com/hmans/schreihals.git'
end
