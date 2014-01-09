class samba::server::config inherits samba {

  file { "${samba_config_dir}":
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
  }

  file { "${samba_config_file}":
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0444',
    require => [File['/etc/samba'], Class['samba::server::install']],
    notify  => Class['samba::server::service']
  }
}

