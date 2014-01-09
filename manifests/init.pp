class samba inherits samba::params {
  include samba::server

  if samba::server::security == 'ads' {
    include samba::server::ads
  }
}
