# Class: nextcloud
# ===========================
#
# Class to install nextcloud server.
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
#      ssl_key_file  => '/etc/nginx/ssl/server.key',
#      ssl_cert_file => '/etc/nginx/ssl/server.crt',
#    }
#
# Authors
# -------
#
# Othalla <othalla.lf@gmail.com>
#
#
class nextcloud (
  $install_dir                = '/var/www/html/nextcloud',
  $data_directory             = '/www/htdocs/nextcloud/data',
  $db_manage                  = true,
  $db_type                    = 'mysql',
  $db_name                    = 'nextcloud',
  $db_user                    = 'nextcloud',
  $db_password                = 'nextcloud',
  $db_host                    = 'localhost',
  $db_table_prefix            = undef,
  $admin_user                 = undef,
  $admin_password             = undef,
  Array[String] $server_names = ['localhost'],
  $http_port                  = 80,
  $https_port                 = 443,
  $ssl                        = true,
  $ssl_key_file               = undef,
  $ssl_cert_file              = undef,
  $php_version                = '7.0'
) {

  if $ssl and !($ssl_cert_file and $ssl_key_file) {
    fail('You must provide certificate file and key file for SSL config.')
  }


  if $db_manage {
    contain nextcloud::database
    contain nextcloud::php
    contain nextcloud::install
    contain nextcloud::webserver
    include nextcloud::config

    Class['nextcloud::database']
    -> Class['nextcloud::php']
    -> Class['nextcloud::install']
    -> Class['nextcloud::webserver']
    -> Class['nextcloud::config']
  } else {
    contain nextcloud::php
    contain nextcloud::install
    contain nextcloud::webserver
    include nextcloud::config

    Class['nextcloud::php']
    -> Class['nextcloud::install']
    -> Class['nextcloud::webserver']
    -> Class['nextcloud::config']
  }


}
