# == Class samba::server::user
#
define samba::server::user (
  $password,
  $user_name = $name,
) {
  require ::samba::server::install

  User <| |> -> Samba::Server::User <| |>

  exec { "add smb account for ${user_name}":
    command => "/bin/echo -e '${password}\\n${password}\\n' | /usr/bin/pdbedit --password-from-stdin -a '${user_name}'",
    unless  => "/usr/bin/pdbedit '${user_name}'",
    notify  => Class['samba::server::service'] #TODO: Is this really required??
  }
}
