class nextcloud::database (
  $db_type = $nextcloud::db_type,
  $db_name = $nextcloud::db_name,
  $db_user = $nextcloud::db_user,
  $db_host = $nextcloud::db_host,
) {

  class {'::mysql::server':
    package_name     => 'mariadb-server',
    service_name     => 'mariadb',
    root_password    => 'rootpassword',
    override_options => {
      mysqld => {
        'log-error' => '/var/log/mysql/mariadb.log',
        'pid-file'  => '/var/run/mysqld/mysqld.pid',
      },
      mysqld_safe => {
        'log-error' => '/var/log/mysql/mariadb.log',
      },
    }
  }
  mysql::db { $db_name:
    user     => $db_user,
    password => $db_type,
    host     => $db_host,
    grant    => ['ALL'],
  }
}
