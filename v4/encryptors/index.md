---
layout: main
title: Encryptors
---

Encryptors
==========

Backup includes the following Encryptors:

- [GPG][encryptor-gpg]
- [OpenSSL][encryptor-openssl]

Only one Encryptor may be configured for each Model.

Once all [Archives][archives] and [Databases][databases] have been processed, Backup will package these into a single
`tar` file. If an Encryptor is configured, this final backup package will be piped through the encryption utility.



{% include markdown_links %}
