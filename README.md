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

### What nextcloud affects

Depending of given parameters, nextcloud class does:

* Install MariaDB with a database for nextcloud (if db managed). Why not Oracle Mysql? Thats not
  even a question!
* Install PHP-fpm with required modules.
* Fetch and extract nextcloud distribution from Internet.
* Install Nginx and configure nextcloud webserver. Why Nginx? Because it is so nice & fast!
* Set preconfigured options for first use.

### Setup Requirements

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

You can provide your own DB if you already for some :

```
class { '::nextcloud':
  ssl_key_file  => '/etc/nginx/ssl/server.key',
  ssl_cert_file => '/etc/nginx/ssl/server.crt',
  db_manage     => false,
  db_host       => 'myhost',
  db_user       => 'myuser',
  db_password   => 'mypassword',
}
```

## Limitations

This module isn't able to generate self-signed certificated when used with SSL.

## Development

This module is actually being developped. New features should come soon!

## Release Notes/Contributors/Etc.

Helo all, will be glad if you provide enhancements!
