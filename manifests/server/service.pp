class samba::server::service ($ensure = running, $enable = true) inherits samba {
  service { $services:
    ensure      => $ensure,
    hasstatus   => true,
    hasrestart  => true,
    enable      => $enable,
    require     => Class['samba::server::config']
  }
}

