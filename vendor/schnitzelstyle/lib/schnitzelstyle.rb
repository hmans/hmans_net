require "schnitzelstyle/version"

# Add our stylesheets to SASS load path
#
Sass::Engine::DEFAULT_OPTIONS[:load_paths] << File.expand_path("../assets/stylesheets/", __FILE__)

module Schnitzelstyle
  # Your code goes here...
end
