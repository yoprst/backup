---
layout: main
title: Installation
---

Installation
============

Backup v4.x is distributed using [RubyGems](https://rubygems.org) and supports
[Ruby](https://www.ruby-lang.org) versions `2.0.0+`, `2.1.0+`, `2.2.0+`.

To install the latest version, run:

    $ gem install sliday_backup

This will install Backup, along with all of it's required dependencies.

### Using sudo

The `gem` commands shown here may need to be run using `sudo`, depending on how Ruby is installed on your system. If
you're using [RVM][], [rbenv][] or [chruby][], then you would most likely _not_ want to use `sudo`. However, if your
installation of Ruby came with your system, or was installed using your system's package manager (yum, apt, etc...),
then you most likely need to use `sudo`. For example, running `gem install backup` as a non-root user with a system
installed Ruby would install Backup only for that user's use. This may or may not be what you want.

{% include markdown_links %}
