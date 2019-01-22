# == Class samba::server::install
#
class samba::server::install(
  $package_name = 'samba'
) {
  package { $package_name:
    ensure => installed
  }
}
