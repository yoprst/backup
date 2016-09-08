---
layout: main
title: Installation
---

Installation
============

Backup v4.x is distributed using [RubyGems](https://rubygems.org) and supports
[Ruby](https://www.ruby-lang.org) versions `2.0.0+`, `2.1.0+`, `2.2.0+`.

To install the latest version, run:

    $ gem install specific_install
    $ gem specific_install https://github.com/yoprst/backup.git

This will install Backup, along with all of it's required dependencies.

See [Release Notes][release-notes] for changes in the latest version.

If you're upgrading from Backup v3.x, see [Upgrading][upgrading].

For Ruby versions `1.9.3`, support was dropped on version `4.1.11` so use an earlier version.
For Ruby versions `1.8.7` and `1.9.2`, please use [Backup v3.x][v3-overview].

### Using Bundler

**Do not add `gem backup` to another application's Gemfile.**
This means you **should not add Backup to a Rails** application's Gemfile.
Backup is not a _gem library_ and should not be treated as a _dependency_ of
another application. Bundler _can_ be used to manage an installation of Backup,
but the reasons for why you might want to do this is beyond the scope of this
document.

See also [this issue](https://github.com/meskyanichi/backup/issues/635) for
more information.

### Using sudo

The `gem` commands shown here may need to be run using `sudo`, depending on how Ruby is installed on your system. If
you're using [RVM][], [rbenv][] or [chruby][], then you would most likely _not_ want to use `sudo`. However, if your
installation of Ruby came with your system, or was installed using your system's package manager (yum, apt, etc...),
then you most likely need to use `sudo`. For example, running `gem install backup` as a non-root user with a system
installed Ruby would install Backup only for that user's use. This may or may not be what you want.



{% include markdown_links %}
