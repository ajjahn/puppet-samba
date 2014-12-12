class samba {
  include samba::server

  if samba::server::security == 'ads' {
    include samba::server::ads
  }

  if samba::server::security == 'domain' {
    include samba::server::domain
  }

}