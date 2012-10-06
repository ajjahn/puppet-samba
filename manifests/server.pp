class samba::server($interfaces = '',
                    $security = '',
                    $server_string = '',
                    $unix_password_sync = '',
                    $workgroup = '') {

  include samba::server::install
  include samba::server::config
  include samba::server::service

  $context = '/files/etc/samba/smb.conf'
  $target = "target[. = 'global']"

  augeas { 'global-section':
    context => $context,
    changes => "set ${target} global",
    require => Class['samba::server::config'],
    notify  => Class['samba::server::service']
  }

  augeas { 'global-interfaces':
    context => $context,
    changes => $interfaces ? {
      default => ["set \"${target}/interfaces\" '${interfaces}'", "set \"${target}/bind interfaces only\" yes"],
      ''      => ["rm \"${target}/interfaces\"", "rm \"${target}/bind interfaces only\""],
    },
    require => Augeas['global-section'],
    notify  => Class['samba::server::service']
  }

  augeas { 'global-security':
    context => $context,
    changes => $security ? {
      default => "set \"${target}/security\" '${security}'",
      ''      => "rm \"${target}/security\"",
    },
    require => Augeas['global-section'],
    notify  => Class['samba::server::service']
  }

  augeas { 'global-server_string':
    context => $context,
    changes => $server_string ? {
      default => "set \"${target}/server string\" '${server_string}'",
      ''      => "rm \"${target}/server string\"",
    },
    require => Augeas['global-section'],
    notify  => Class['samba::server::service']
  }

  augeas { 'global-unix_password_sync':
    context => $context,
    changes => $unix_password_sync ? {
      default => "set \"${target}/unix password sync\" '$unix_password_sync'",
      '' => "rm \"${target}/unix_password_sync\"",
    },
    require => Augeas['global-section'],
    notify => Class['samba::server::service']
  }

  augeas { 'global-workgroup':
    context => $context,
    changes => $workgroup ? {
      default => "set ${target}/workgroup '${workgroup}'",
      ''      => "rm ${target}/workgroup",
    },
    require => Augeas['global-section'],
    notify  => Class['samba::server::service']
  }
}
