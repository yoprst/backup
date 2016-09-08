---
layout: main
title: Overview
---

Backup v4.x Overview
====================

Backup allows you to _model_ your backup jobs using a Ruby DSL:

```rb
Backup::Model.new(:my_backup, 'Description for my_backup') do
  # ... Model Components ...
end
```

The `:my_backup` symbol is the model's `trigger` and used to perform the job:

```
$ backup perform --trigger my_backup
```

Below is an overview of the _Model Components_ available, which are added to define the actions to be performed.

See also [Getting Started][getting-started] for a simple walk-through using Backup's [Generator][generator]
to familiarize yourself with setting up, configuring and running a backup job.


[Archives][archives] and [Databases][databases]
-----------------------------------------------

Archives create basic `tar` archives. Both **GNU** and **BSD** `tar` are supported.

Databases create backups of one of the following supported databases:

- [MySQL][database-mysql]
- [PostgreSQL][database-postgresql]
- [MongoDB][database-mongodb]
- [Redis][database-redis]
- [Riak][database-riak]
- [SQLite][database-sqlite]

Any number of Archives and Databases may be defined within a backup _model_.


[Compressors][compressors] and [Encryptors][encryptors]
-------------------------------------------------------

Adding a Compressor to your backup will compress all the Archives and Database backups within your final archive package.
Backup includes a [Gzip][compressor-gzip], [Bzip2][compressor-bzip2] and [Custom][compressor-custom] compressor.

Adding an Encryptor allows you to encrypt your final backup package.
Backup includes a [OpenSSL][encryptor-openssl] and [GPG][encryptor-gpg] encryptor.

Your final backup _package_ might look something like this:

```text
$ gpg --decrypt my_backup.tar.gpg --outfile my_backup.tar
$ tar -tvf my_backup.tar
  my_backup/
  my_backup/archives/
  my_backup/archives/user_avatars.tar.gz
  my_backup/archives/log_files.tar.gz
  my_backup/databases/
  my_backup/databases/PostgreSQL.sql.gz
  my_backup/databases/Redis.rdb.gz
```


[Storages][storages]
--------------------

You can use any number of the following Storages to store your backup:

- [Sliday  Backup Storage][storage-sliday]
- [Amazon S3][storage-s3]
- [Rackspace Cloud Files][storage-cloudfiles]
- [Ninefold][storage-ninefold]
- [Dropbox][storage-dropbox]
- [FTP][storage-ftp]
- [SFTP][storage-sftp]
- [SCP][storage-scp]
- [RSync][storage-rsync]
- [Local][storage-local]

All of the above Storages _(except RSync)_ support:

- [Cycling][storages] to keep and rotate multiple copies of your stored backups.

- [Splitter][splitter] to break up a large backup package into smaller files.


[Syncers][syncers]
------------------

Syncers are processed after your final backup package has been stored and allow you to perform file synchronization.

Backup includes the following Syncers:

- [Amazon S3][syncer-s3] Cloud Syncer
- [Rackspace Cloud Files][syncer-cloudfiles] Cloud Syncer
- [RSync][syncer-rsync] Syncer for local, local-to-remote (`Push`) or remote-to-local (`Pull`) operations.

A backup _model_ may contain _only_ Syncers as well.


[Notifiers][notifiers]
----------------------

Notifiers are used to send notifications upon successful and/or failed completion of your backup _model_.

Supported notification services include:

- [Email][notifier-mail] _(SMTP, Sendmail, Exim and File delivery)_
- [Twitter][notifier-twitter]
- [Campfire][notifier-campfire]
- [Prowl][notifier-prowl]
- [Hipchat][notifier-hipchat]
- [Pushover][notifier-pushover]
- [Nagios][notifier-nagios]
- [HTTP POST][notifier-httppost] _(compatible with a variety of services)_
- [Zabbix][notifier-zabbix]


{% include markdown_links %}
