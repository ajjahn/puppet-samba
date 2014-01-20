define samba::server::option ( $value = '' ) {
  $incl    = $samba::server::incl
  $context = $samba::server::context
  $target  = $samba::server::target

  $changes = $value ? {
    default => "set \"${target}/$name\" \"$value\"",
    ''      => "rm ${target}/$name",
  }

  augeas { "samba-$name":
    incl    => $incl,
    lens    => 'Samba.lns',
    context => $context,
    changes => $changes,
    require => Augeas['global-section'],
    notify  => Class['Samba::Server::Service']
  }
}