class samba::server::install {

  case $::operatingsystem {
    'gentoo': {
      package { 'net-fs/samba':
        ensure => installed,
      }
    }
    default: {
      package { 'samba':
        ensure => installed
      }
    }
  }
}