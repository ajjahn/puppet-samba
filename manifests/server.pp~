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


  set_samba_option {
    'interfaces':           value => $interfaces;
    'bind interfaces only': value => 'yes';
    'security':             value => $security;
    'server string':        value => $server_string;
    'unix password sync':   value => $unix_password_sync;
    'workgroup':            value => $workgroup;
  }
}

define set_samba_option ( $value = '', $signal = 'samba::server::service' ) {
  $context = $samba::server::context
  $target = $samba::server::target
  $changes = $value ? {
    default => "set \"${target}/$name\" \"$value\"",
    ''      => "rm ${target}/$name",
  }

  augeas { "samba-$name":
    context => $context,
    changes => $changes,
    require => Augeas['global-section'],
    notify  => Class[$signal]
  }
}
