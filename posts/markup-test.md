---
title: Schreihals Markup test
disqus: false
---

This is a test!

    :::ruby
    require 'rubygems'
    require 'bundler'
    Bundler.require

    require 'schreihals'

    class MyBlog < Schreihals::App
      set :blog_title, "hmans.net"
      set :author_name, "Hendrik Mans"
      set :disqus_name, "hmans"
    end

    run MyBlog
