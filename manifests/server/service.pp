# == Class samba::server::server
#
class samba::server::service (
  $ensure = running,
  $enable = true
) inherits samba::server::params {

  service { $service_name :
    ensure      => $ensure,
    hasstatus   => true,
    hasrestart  => true,
    enable      => $enable,
    require     => Class['samba::server::config']
  }
}
