class nextcloud::install {

  archive { '/var/www/html/nextcloud-13.0.2.tar.bz2':
    ensure       => present,
    extract      => true,
    extract_path => '/var/www/html',
    source       => 'https://download.nextcloud.com/server/releases/nextcloud-13.0.2.tar.bz2',
    creates      => '/var/www/html/nextcloud',
    cleanup      => true,
    user         => 'www-data',
    group        => 'www-data',
  }
}
