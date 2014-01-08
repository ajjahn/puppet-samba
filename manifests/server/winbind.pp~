class samba::server::winbind ($ensure = running, $enable = true) {
  $service_name = 'winbind'

  notify { 'winbind-service':
    message => 'Check winbind service',
  }

  service { $service_name:
    ensure      => $ensure,
    hasstatus   => true,
    hasrestart  => true,
    enable      => $enable,
    require     => Class['samba::server::config']
  }

}
