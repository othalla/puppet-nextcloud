# Class: nextcloud
# ===========================
#
# Full description of class nextcloud here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'nextcloud':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
# Author Name <author@domain.com>
#
# Copyright
# ---------
#
# Copyright 2018 Your name here, unless otherwise noted.
#
class nextcloud (
  $install_dir     = '/var/www/html/nextcloud',
  $data_directory  = '/www/htdocs/nextcloud/data',
  $db_type         = 'mysql',
  $db_name         = 'nextcloud',
  $db_user         = 'nextcloud',
  $db_password     = 'nextcloud',
  $db_host         = 'localhost',
  $db_table_prefix = undef,
  $admin_user      = 'root',
  $admin_password  = 'password',
  $http_port       = 80,
  $https_port      = 443,
  $ssl             = true,
  $ssl_key_file    = '/etc/nginx/ssl/cert.key',
  $ssl_cert_file   = '/etc/nginx/ssl/cert.crt',
) {

  include nextcloud::database
  include nextcloud::php
  include nextcloud::install
  include nextcloud::webserver
  include nextcloud::config
  Class['nextcloud::database']
  -> Class['nextcloud::php']
  -> Class['nextcloud::install']
  -> Class['nextcloud::webserver']
  -> Class['nextcloud::config']

}
