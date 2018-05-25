# nextcloud

#### Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with nextcloud](#setup)
    * [What nextcloud affects](#what-nextcloud-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with nextcloud](#beginning-with-nextcloud)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

This module install Nextcloud.

## Setup

### What nextcloud affects **OPTIONAL**

Depending of given parameters, nextcloud class does:

* Install MariaDB with a database for nextcloud (if db managed).
* Install PHP-fpm with required modules.
* Fetch and extract nextcloud distribution.
* Install nginx and configure nextcloud webserver.
* set preconfigured options for first use.

### Setup Requirements **OPTIONAL**

If SSL choosed, you must provide and put ssl cert & key on nextcloud host.

### Beginning with nextcloud

None

## Usage

For test, use it without HTTPS like :
```
class { '::nextcloud':
  ssl => false,
}
```

For production usage, use it with SSL and provide certificate as required :
```
class { '::nextcloud':
  ssl_key_file  => '/etc/nginx/ssl/server.key',
  ssl_cert_file => '/etc/nginx/ssl/server.crt',
}
```

## Limitations

This module isn't able to generate self-signed certificated when used with SSL.

## Development

This module is actually being developped. New features should come soon!

## Release Notes/Contributors/Etc. **Optional**

Helo all, will be glad if you provide enhancements!
