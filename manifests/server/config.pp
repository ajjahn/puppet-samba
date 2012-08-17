class samba::server::config {
  
  file { "/etc/samba/smb.conf":
    ensure => $ensure,
    owner => root,
    group => root,
    require => Class["samba::server::install"],
    notify => Class["samba::server::service"]
  }
  
}