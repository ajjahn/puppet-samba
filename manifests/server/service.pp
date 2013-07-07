class samba::server::service ($ensure = running, $enable = true) {
  case $::osfamily {
      Redhat: { $service_name = 'smb' }
      Debian: { $service_name = 'smbd' }
      Gentoo: { $service_name = 'samba' }
      Archlinux: { $service_name = 'smbd' }

      # Currently Gentoo has $::osfamily = "Linux". This should change in
      # Factor 1.7.0 <http://projects.puppetlabs.com/issues/17029>, so
      # adding workaround.
      Linux: {
        case $::operatingsystem {
          Gentoo:  { $service_name = 'samba' }
          default: { fail("$::operatingsystem is not supported by this module.") }
        }
      }
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
