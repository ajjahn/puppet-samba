class samba::server($workgroup = '',
                    $server_string = '') {
  include samba::server::install
  include samba::server::config
  include samba::server::service

  $context = "/files/etc/samba/smb.conf"
  $target = "target[. = 'global']"

  augeas { 'global-section':
    context => $context,
    changes => "set ${target} global",
    require => Class["samba::server::config"],
    notify => Class['samba::server::service']
  }

  augeas { 'global-workgroup':
    context => $context,
    changes => $workgroup ? {
      default => "set ${target}/workgroup '$workgroup'",
      '' => "rm ${target}/workgroup",
    },
    require => Augeas['global-section'],
    notify => Class['samba::server::service']
  }

  augeas { 'global-server_string':
    context => $context,
    changes => $server_string ? {
      default => "set \"${target}/server string\" '$server_string'",
      '' => "rm \"${target}/server string\"",
    },
    require => Augeas['global-section'],
    notify => Class['samba::server::service']
  }

}
