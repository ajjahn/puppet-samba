class samba::server::service ($ensure = running, $enable = true) {
  case $::osfamily {
      Redhat: { $service_name = 'smb' }

      #On Debian family: Debian 7 => samba , Ubuntu => smbd
      #Others, I don't know, hope 'samba' will works
      Debian: {
        case $::operatingsystem{
                Debian: { $service_name = 'samba' }
                Ubuntu: { $service_name = 'smbd'}
                default: { $service_name='samba'}
        }
      }
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
