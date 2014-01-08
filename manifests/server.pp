class samba::server($interfaces = '',
                    $security = '',
                    $server_string = '',
                    $unix_password_sync = '',
                    $workgroup = '',
                    $bind_interfaces_only = true,
                    $realm = '',
                    $machine_password_timeout = '',
                    $unix_extensions = '') inherits samba {

  include samba::server::install
  include samba::server::config
  include samba::server::service

#  $lense       = $lense
#  $config_dir  = $samba_config_dir
#  $config_file = $samba_config_file
  $context     = "/files${samba_config_file}"
  $target      = "target[. = 'global']"

  augeas { 'global-section':
    context => $context,
    changes => "set ${target} global",
    require => Class['samba::server::config'],
    notify  => Class['samba::server::service']
  }

  set_samba_option {
    'interfaces':                value => $interfaces;
    'bind interfaces only':      value => $bind_interfaces_only, bool => true;
    'security':                  value => $security;
    'server string':             value => $server_string;
    'unix password sync':        value => $unix_password_sync;
    'workgroup':                 value => $workgroup;
    'realm':                     value => $realm;
    'machine password timeout':  value => $machine_password_timeout;
    'unix extensions':           value => $unix_extensions, bool => true;
  }
}

define set_samba_option ( $value = '', $signal = 'samba::server::service', $bool = false ) {
  $context = $samba::server::context
  $target = $samba::server::target
  if ($bool) {
    $changes = $value ? {
      true    => "set \"${target}/$name\" yes",
      false   => "set \"${target}/$name\" no",
      default => "rm ${target}/$name"
    }
  }
  else {
    $changes = $value ? {
      default => "set \"${target}/$name\" \"$value\"",
      ''      => "rm ${target}/$name",
    }
  }

  augeas { "samba-$name":
    context => $context,
    changes => $changes,
    require => Augeas['global-section'],
    notify  => Class[$signal]
  }
}


