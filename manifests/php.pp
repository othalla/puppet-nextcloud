class nextcloud::php {

  class { '::php::globals':
    php_version => '7.1',
    config_root => '/etc/php/7.1',
  }
  -> class { '::php':
    ensure       => latest,
    manage_repos => false,
    fpm          => true,
    dev          => true,
    composer     => true,
    pear         => true,
    phpunit      => false,
    extensions   => {
      mbstring  => {},
      xmlrpc    => {},
      soap      => {},
      apcu      => {},
      smbclient => {},
      ldap      => {},
      redis     => {},
      gd        => {},
      xml       => {},
      intl      => {},
      json      => {},
      imagick   => {},
      mysql     => {},
      cli       => {},
      mcrypt    => {},
      zip       => {},
      curl      => {},
    },
  }
}
