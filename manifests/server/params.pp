# == Class samba::server::params
#
class samba::server::params {
  case $::osfamily {
    'Redhat': { $service_name = 'smb' }
    'Debian': {
      case $::operatingsystem {
        'Debian': {
          case $::operatingsystemmajrelease {
            '7' : { $service_name = 'samba' }
            default: { $service_name = 'smbd' }
          }
        }
        'Ubuntu': {
          $service_name = 'smbd'
          $nmbd_name = 'nmbd'
        }
        default: { $service_name = 'samba' }
      }
    }
    'Gentoo': { $service_name = 'samba' }
    'Archlinux': {
      $service_name = 'smbd'
      $nmbd_name = 'nmbd'
    }

    # Currently Gentoo has $::osfamily = "Linux". This should change in
    # Factor 1.7.0 <http://projects.puppetlabs.com/issues/17029>, so
    # adding workaround.
    'Linux': {
      case $::operatingsystem {
        'Gentoo':  { $service_name = 'samba' }
        default: { fail("${::operatingsystem} is not supported by this module.") }
      }
    }
    default: { fail("${::osfamily} is not supported by this module.") }
  }
}
