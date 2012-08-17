class samba::server::service {
  
  service { "smbd":
    ensure => running,
    hasstatus => true,
    hasrestart => true,
    enable => true,
    require => Class["samba::server::config"]
  }
    
}