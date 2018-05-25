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

This section is where you describe how to customize, configure, and do the
fancy stuff with your module here. It's especially helpful if you include usage
examples and code samples for doing things with your module.

## Reference

Here, include a complete list of your module's classes, types, providers,
facts, along with the parameters for each. Users refer to this section (thus
the name "Reference") to find specific details; most users don't read it per
se.

## Limitations

This is where you list OS compatibility, version compatibility, etc. If there
are Known Issues, you might want to include them under their own heading here.

## Development

Since your module is awesome, other users will want to play with it. Let them
know what the ground rules for contributing are.

## Release Notes/Contributors/Etc. **Optional**

If you aren't using changelog, put your release notes here (though you should
consider using changelog). You can also add any additional sections you feel
are necessary or important to include here. Please use the `## ` header.
