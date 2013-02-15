class samba::server::service ($ensure = running, $enable = true) {
  case $::osfamily {
      Redhat:  { $service_name = 'smb' }
      Debian:  { $service_name = 'smbd' }
      default: { fail("$::osfamily is not supported by this module.") }
    }

  service { "$service_name" :
    ensure      => $ensure,
    hasstatus   => true,
    hasrestart  => true,
    enable      => $enable,
    require     => Class['samba::server::config']
  }

}
