class samba::server::service ($ensure = running, $enable = true) {
  case $operatingsystem {
      centos, redhat: { $service_name = 'smb' }
      debian, ubuntu: { $service_name = 'smbd' }
    }

  service { "$service_name" :
    ensure      => $ensure,
    hasstatus   => true,
    hasrestart  => true,
    enable      => $enable,
    require     => Class['samba::server::config']
  }

}
