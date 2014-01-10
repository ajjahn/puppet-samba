class samba::server($interfaces = '',
                    $security = '',
                    $server_string = '',
                    $unix_password_sync = '',
                    $workgroup = '',
                    $bind_interfaces_only = 'yes',) {

  include samba::server::install
  include samba::server::config
  include samba::server::service

  $incl    = '/etc/samba/smb.conf'
  $context = "/files/etc/samba/smb.conf"
  $target  = "target[. = 'global']"

  augeas { 'global-section':
    incl    => $incl,
    lens    => 'Samba.lns',
    context => $context,
    changes => "set ${target} global",
    require => Class['samba::server::config'],
    notify  => Class['samba::server::service']
  }


  set_samba_option {
    'interfaces':           value => $interfaces;
    'bind interfaces only': value => $bind_interfaces_only;
    'security':             value => $security;
    'server string':        value => $server_string;
    'unix password sync':   value => $unix_password_sync;
    'workgroup':            value => $workgroup;
  }

  file {'check_samba_user':
    # script checks to see if a samba account exists for a given user
    path    => '/sbin/check_samba_user',
    owner   => root,
    group   => root,
    mode    => "0755",
    content => template("${module_name}/check_samba_user"),
  }

  file {'add_samba_user':
    # script creates a new samba account for a given user and password
    path    => '/sbin/add_samba_user',
    owner   => root,
    group   => root,
    mode    => "0755",
    content => template("${module_name}/add_samba_user"),
  }
}

define set_samba_option ( $value = '', $signal = 'samba::server::service' ) {
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
    notify  => Class[$signal]
  }
}
