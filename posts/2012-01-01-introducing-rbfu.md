---
title: Introducing rbfu
status: draft
summary: rbfu allows you to switch between multiple installed Ruby versions. Yes, kind of like RVM and rbenv -- except it's really, really lightweight.
---

If you develop with Ruby, you probably have to juggle various different versions of it for your different projects. That horrible legacy project you're maintaining is stuck on a heavily customized fork of 1.8.7, your side project is using funky new 1.9.3, and then there's that thing you want to try using JRuby. Eep!

There's a bunch of tools available that attempt to make switching between these different versions easy; the best known of the two appear to be Wayne Seguin's [RVM](http://beginrescueend.com/) and, with increasing popularity, Sam Stephenson's [rbenv](https://github.com/sstephenson/rbenv).

While using (and enjoying!) each of them for quite a while, a simple question started to nag me more and more: **why are they so complex?**


### It's really quite simple

Turns out that switching to a specific version of Ruby is really quite simple: there's a total of two environment variables that need to be modified. Two! Variables! Have you browsed RVM's documentation lately? Or rbenv's source code?

Both tools seem to be suffering from severe cases of feature creep (which is particularly unfortunate in the case of rbenv, which makes a point of being "simple"). I suppose that if you're looking for a Ruby version management tool that does *everything*, that may be a good thing. I, for my part, would prefer something that is just as simple as the thing it's supposed to do.


### Enter rbfu!

![rbfu](http://dl.dropbox.com/u/7288/calepin/rbfu-logo.png)

So I ended up building my own solution to the problem: it's called **rbfu**, [it's on GitHub](https://github.com/hmans/rbfu) (of course), and I've just tagged and released the first proper version ([0.2.0](https://github.com/hmans/rbfu/tree/v0.2.0)).

So, what does rbfu do?

* switch between multiple installed versions of Ruby.

That is all.

It doesn't compile and install Rubies (use [ruby-build](https://github.com/sstephenson/ruby-build); it's great) or manage gemsets, like RVM does (use [Bundler](http://gembundler.com/); it's great). It also doesn't need to be rehashed constantly, like rbenv. It doesn't have a plugin architecture, it doesn't need any modifications to your code, it doesn't get in the way when you need to do something crazy. It's really quite simple ([here's the complete code](https://github.com/hmans/rbfu/blob/v0.2.0/bin/rbfu)).


### Just how does it work?

rbfu assumes that all your favorite versions of Ruby are installed into directories named `$HOME/.rbfu/rubies/$VERSION/`. You can use [ruby-build](https://github.com/sstephenson/ruby-build) to install new versions like this:

    ruby-build 1.8.7-p352 $HOME/.rbfu/rubies/1.8.7-p352
    ruby-build 1.9.2-p290 $HOME/.rbfu/rubies/1.9.2-p290
    ruby-build 1.9.3-p0   $HOME/.rbfu/rubies/1.9.3-p0

So how do you switch to a specific version? At its most basic, rbfu requires you to run it explicitly, prefixing whatever commands you want to run within the context of a specific version of Ruby:

    rbfu @1.9.3-p0 rake db:migrate

Generally speaking, this is what rbfu's invocation syntax looks like:

    rbfu [@<version>] <command>

As you can see, the `@<version>` parameter is optional. When it's omitted, rbfu will look for a file named `.rbfu-version` (containing a version number) in your current directory and your home directory, in that order. This allows you to set up global and project-specific defaults:

    echo "1.9.3-p0" > ~/.rbfu-version
    echo "1.8.7-p352" > ~/src/some_old_project/.rbfu-version

Of course, adding another prefix to your favorite development commands can get a bit silly:

    rbfu bundle exec cap integration deploy
    # what?

So rbfu also allows you to configure your current shell environment for a specific Ruby version, using its spin-off `rbfu-env` command:

    rbfu-env @1.8.7

In addition to that, rbfu has an optional "automatic mode" that, like RVM, hooks into the `cd` command and switches Ruby versions automatically whenever you enter a directory that contains a `.rbfu-version` file. (Some people don't like this behavior, which is why you can opt out of it if needed.)
