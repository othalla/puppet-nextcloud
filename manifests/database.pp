class nextcloud::database {

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
  mysql::db { 'nextcloud':
    user     => 'nextcloud',
    password => 'nextcloud',
    host     => 'localhost',
    grant    => ['ALL'],
  }
}
