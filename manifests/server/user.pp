# == Class samba::server::user
#
define samba::server::user (
  $password,
  $user_name = $name,
) {
  require ::samba::server::install

  exec { "add smb account for ${user_name}":
    command => "/bin/echo -e '${password}\\n${password}\\n' | /usr/bin/pdbedit --password-from-stdin -a '${user_name}'",
    unless  => "printf ${password} | iconv -f ASCII -t UTF-16LE | openssl md4 | awk '{print \"pdbedit -wL ${user_name} | grep -qi \"\$2}' | sh",
    require => [ User[$user_name] ],
    notify  => Class['samba::server::service'] #TODO: Is this really required??
  }
}
