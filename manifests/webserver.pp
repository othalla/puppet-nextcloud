class nextcloud::webserver {

  class { 'nginx':
    manage_repo => false,
  }
  -> nginx::resource::server { 'nextcloud_server':
    ensure      => present,
    server_name => ['nextcloud', 'nextcloud.fqdn.local'],
    listen_port => 80,
    www_root    => '/var/www/html/nextcloud',
  }
}
#nginx::resource::location { "${name}_root":
#ensure          => present,
#server           => "${name}.${::domain} ${name}",
#www_root        => "${full_web_path}/${name}/",
#location        => '/',
#index_files     => ['index.php', 'index.html', 'index.htm'],
#proxy           => undef,
#fastcgi         => "127.0.0.1:${backend_port}",
#fastcgi_script  => undef,
#location_cfg_append => {
#fastcgi_connect_timeout => '3m',
#fastcgi_read_timeout    => '3m',
#fastcgi_send_timeout    => '3m'
#}
#}
# Nginx with PHP mod on
