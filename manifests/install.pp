class nextcloud::install {

  file { '/var/www/html/nextcloud':
    ensure => directory,
    owner  => 'www-data',
    group  => 'www-data',
  }
  -> archive { '/var/www/html/nextcloud-13.0.2.tar.bz2':
    ensure       => present,
    path         => '/tmp/nextcloud-13.0.2.tar.bz2',
    extract      => true,
    extract_path => '/var/www/html',
    source       => 'https://download.nextcloud.com/server/releases/nextcloud-13.0.2.tar.bz2',
    creates      => '/var/www/html/nextcloud/index.php',
    cleanup      => true,
    user         => 'www-data',
    group        => 'www-data',
  }
}
