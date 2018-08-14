class nextcloud::config (
  $install_dir     = $nextcloud::install_dir,
  $data_directory  = $nextcloud::db_user,
  $db_type         = $nextcloud::db_type,
  $db_name         = $nextcloud::db_name,
  $db_user         = $nextcloud::db_user,
  $db_password     = $nextcloud::db_password,
  $db_host         = $nextcloud::db_host,
  $db_table_prefix = $nextcloud::db_table_prefix,
  $admin_user      = $nextcloud::admin_user,
  $admin_password  = $nextcloud::admin_password,
) {

  file { "${install_dir}/config/autoconfig.php":
    ensure  => present,
    owner   => 'www-data',
    group   => 'www-data',
    mode    => '0640',
    content => template('nextcloud/autoconfig.php.erb'),
  }
}
