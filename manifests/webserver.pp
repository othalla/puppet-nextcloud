class nextcloud::webserver (
  $ssl        = $nextcloud::ssl,
  $http_port  = $nextcloud::http_port,
  $https_port = $nextcloud::https_port,
) {
  if $ssl == true {
    $port = $https_port
  } else {
    $port = $http_port
  }

  class { 'nginx':
    manage_repo    => false,
  }
  if $ssl {
    nginx::resource::server { 'nextcloud_server_redirect':
      ensure               => present,
      server_name          => ['nextcloud', 'nextcloud.int.othalland.xyz'],
      listen_port          => $http_port,
      ssl_redirect         => true,
      ssl_redirect_port    => $https_port,
      use_default_location => false,
    }
  }
  nginx::resource::server { 'nextcloud_server_main':
    ensure               => present,
    server_name          => ['nextcloud', 'nextcloud.int.othalland.xyz'],
    ssl                  => true,
    ssl_cert             => '/tmp/server.crt',
    ssl_key              => '/tmp/server.key',
    listen_port          => $port,
    http2                => true,
    www_root             => '/var/www/html/nextcloud',
    client_max_body_size => '512M',
    use_default_location => false,
    add_header           => {
      'X-Content-Type-Options'            => 'nosniff',
      'X-XSS-Protection'                  => '1; mode=block',
      'X-Robots-Tag'                      => 'none',
      'X-Download-Options'                => 'noopen',
      'X-Permitted-Cross-Domain-Policies' => 'none',
    },
    server_cfg_prepend   => {
      'gzip'            => 'on',
      'gzip_vary'       => 'on',
      'gzip_comp_level' => '4',
      'gzip_min_length' => '256',
      'gzip_proxied'    => 'expired no-cache no-store private no_last_modified no_etag auth',
      'gzip_types'      => 'plication/atom+xml application/javascript application/json application/ld+json application/manifest+json application/rss+xml application/vnd.geo+json application/vnd.ms-fontobject application/x-font-ttf application/x-web-app-manifest+json application/xhtml+xml application/xml font/opentype image/bmp image/svg+xml image/x-icon text/cache-manifest text/css text/plain text/vcard text/vnd.rim.location.xloc text/vtt text/x-component text/x-cross-domain-policy',
    },
  }
  nginx::resource::location { "root":
    ensure        => present,
    ssl           => true,
    ssl_only      => true,
    index_files   => [],
    server        => "nextcloud_server_main",
    location      => '/',
    rewrite_rules => ['^ /index.php$uri'],
    priority      => 401,
  }
  -> nginx::resource::location { "misc":
    ensure              => present,
    ssl                 => true,
    ssl_only            => true,
    index_files         => [],
    server              => "nextcloud_server_main",
    location            => '~ ^/(?:build|tests|config|lib|3rdparty|templates|data)/',
    location_deny       => ['all'],
    priority            => 402,
  }
  -> nginx::resource::location { "internal":
    ensure              => present,
    ssl                 => true,
    ssl_only            => true,
    index_files         => [],
    server              => "nextcloud_server_main",
    location            => '~ ^/(?:\.|autotest|occ|issue|indie|db_|console)',
    location_deny       => ['all'],
    priority            => 403,
  }
  -> nginx::resource::location { "nextcloud":
    ensure              => present,
    ssl                 => true,
    ssl_only            => true,
    index_files         => [],
    server              => "nextcloud_server_main",
    location            => '~ ^/(?:index|remote|public|cron|core/ajax/update|status|ocs/v[12]|updater/.+|ocs-provider/.+)\.php(?:$|/)',
    raw_append          => [
      'fastcgi_split_path_info ^(.+\.php)(/.*)$;',
      'include fastcgi_params;',
      'fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;',
      'fastcgi_param PATH_INFO $fastcgi_path_info;',
      'fastcgi_param HTTPS on;',
      'fastcgi_param modHeadersAvailable true;',
      'fastcgi_param front_controller_active true;',
      'fastcgi_pass php-handler;',
      'fastcgi_intercept_errors on;',
      'fastcgi_request_buffering off;',
    ],
    priority            => 404,
  }
  -> nginx::resource::location { "updater":
    ensure      => present,
    ssl         => true,
    ssl_only    => true,
    index_files => ['index.php'],
    server      => "nextcloud_server_main",
    location    => '~ ^/(?:updater|ocs-provider)(?:$|/)',
    try_files   => ['$uri/ =404'],
    priority    => 405,
  }
  -> nginx::resource::location { "css_js":
    ensure              => present,
    ssl                 => true,
    ssl_only            => true,
    index_files         => ['index.php'],
    server              => "nextcloud_server_main",
    location            => '~ \.(?:css|js|woff|svg|gif)$',
    try_files           => ['$uri', '/index.php$uri$is_args$args'],
    add_header          => {
      'Cache-Control'                     => 'public, max-age=15778463',
      'X-Content-Type-Options'            => 'nosniff',
      'X-XSS-Protection'                  => '1; mode=block',
      'X-Robots-Tag'                      => 'None',
      'X-Download-Options'                => 'noopen',
      'X-Permitted-Cross-Domain-Policies' => 'none',
    },
    location_cfg_append => { 'access_log' => 'off' },
    priority            => 406,
  }
  -> nginx::resource::location { "static_media_pictures":
    ensure              => present,
    ssl                 => true,
    ssl_only            => true,
    index_files         => ['index.php'],
    server              => "nextcloud_server_main",
    location            => '~ \.(?:png|html|ttf|ico|jpg|jpeg)$',
    try_files           => ['$uri', '/index.php$uri$is_args$args'],
    location_cfg_append => { 'access_log' => 'off' },
    priority            => 407,
  }
  nginx::resource::upstream { 'php-handler':
    members => [
      'unix:/run/php/php7.0-fpm.sock',
    ],
  }
}
