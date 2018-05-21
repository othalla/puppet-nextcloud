class nextcloud::php {

  $php_extensions = [
    'php7.0-mbstring',
    'php7.0-xmlrpc',
    'php7.0-soap',
    'php7.0-ldap',
    'php7.0-gd',
    'php7.0-xml',
    'php7.0-intl',
    'php7.0-json',
    'php7.0-mysql',
    'php7.0-cli',
    'php7.0-mcrypt',
    'php7.0-curl',
    'php7.0-zip'
  ]
  class { 'phpfpm':
    process_max  => 20,
    package_name => 'php7.0-fpm',
    poold_purge => true,
  }
  -> phpfpm::pool { 'nextcloud':
    listen => '/run/php/php7.0-fpm.sock',
  }
  -> package { $php_extensions:
    ensure => present,
  }
}
