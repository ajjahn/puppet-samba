class samba::server($interfaces = '',
                    $security = '',
                    $server_string = '',
                    $unix_password_sync = '',
                    $encrypt_passwords = '',
                    $workgroup = '',
                    $socket_options = '',
                    $deadtime = '',
                    $keepalive = '',
                    $load_printers = '',
                    $printing = '',
                    $printcap_name = '',
                    $disable_spoolss = '',
                    $bind_interfaces_only = 'yes',
                    $netbios_name = $::hostname,
                    $name_resolve_order = '',
                    $log_file = '/var/log/samba.log',
                    $log_level = '1',
                    $include = '',
                    $wide_links = ''
) {

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

  samba::server::option {
    'interfaces':           value => $interfaces;
    'bind interfaces only': value => $bind_interfaces_only;
    'security':             value => $security;
    'server string':        value => $server_string;
    'unix password sync':   value => $unix_password_sync;
    'encrypt passwords':    value => $encrypt_passwords;
    'workgroup':            value => $workgroup;
    'socket options':       value => $socket_options;
    'deadtime':             value => $deadtime;
    'keepalive':            value => $keepalive;
    'load_printers':        value => $load_printers;
    'printing':             value => $printing;
    'printcap_name':        value => $printcap_name;
    'disable_spoolss':      value => $disable_spoolss;
    'netbios name':         value => $netbios_name;
    'name resolve order':   value => $name_resolve_order;
    'log file':             value => $log_file;
    'log level':            value => $log_level;
    'include':              value => $include;
    'wide links':           value => $wide_links;
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
