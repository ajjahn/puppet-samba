class samba::server::install {
  package { 'samba':
    ensure => installed
  }
}