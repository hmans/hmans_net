source 'https://rubygems.org'

# we need to override data_mapper for the time being.
gem 'document_mapper', :git => 'git://github.com/hmans/document_mapper.git', :branch => "after_load_hook"

# use development versions of our two gems.
gem 'schnitzelstyle',  :git => 'git://github.com/hmans/schnitzelstyle.git'
gem 'schreihals',      :git => 'git://github.com/hmans/schreihals.git'

# for local development:
#
# gem 'schnitzelstyle', :path => '../schnitzelstyle'
# gem 'schreihals',     :path => '../schreihals'

group :development do
  gem 'thin'
end
