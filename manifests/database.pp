class nextcloud::database (
  $db_type          = $nextcloud::db_type,
  $db_name          = $nextcloud::db_name,
  $db_user          = $nextcloud::db_user,
  $db_password      = $nextcloud::db_password,
  $db_host          = $nextcloud::db_host,
  $db_root_password = $nextcloud::db_root_password,
) {

  class {'::mysql::server':
    package_name     => 'mariadb-server',
    service_name     => 'mariadb',
    root_password    => $db_root_password,
    override_options => {
      mysqld      => {
        'log-error' => '/var/log/mysql/mariadb.log',
        'pid-file'  => '/var/run/mysqld/mysqld.pid',
        'plugin-load-add'  => 'auth_socket.so',
      },
      mysqld_safe => {
        'log-error' => '/var/log/mysql/mariadb.log',
      },
    }
  }
  mysql::db { $db_name:
    user     => $db_user,
    password => $db_password,
    host     => $db_host,
    grant    => ['ALL'],
  }
}
