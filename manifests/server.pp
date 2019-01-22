# == Class samba::server
#
class samba::server($bind_interfaces_only = 'yes',
                    $deadtime = '',
                    $disable_spoolss = '',
                    $dns_proxy = '',
                    $guest_account = '',
                    $keepalive = '',
                    $kernel_oplocks = '',
                    $load_printers = '',
                    $log_file = '',
                    $map_to_guest = '',
                    $max_log_size = '',
                    $netbios_name = '',
                    $obey_pam_restrictions = '',
                    $os_level = '',
                    $package_name = 'samba',
                    $pam_password_change = '',
                    $panic_action = '',
                    $passdb_backend = '',
                    $passwd_chat = '*Enter\snew\s*\spassword:* %n\n *Retype\snew\s*\spassword:* %n\n *password\supdated\ssuccessfully* .',
                    $passwd_program = '',
                    $preferred_master = '',
                    $printcap_name = '',
                    $printing = '',
                    $security = '',
                    $server_role = '',
                    $server_string = '',
                    $shares = {},
                    $socket_options = '',
                    $syslog = '',
                    $unix_password_sync = '',
                    $usershare_allow_guests = '',
                    $users = {},
                    $workgroup = '',
                    $interfaces = '' ) {

  class { '::samba::server::install':
    package_name => $package_name,
  }
  include samba::server::config
  include samba::server::service

  $incl    = '/etc/samba/smb.conf'
  $context = '/files/etc/samba/smb.conf'
  $target  = 'target[. = "global"]'

  augeas { 'global-section':
    incl    => $incl,
    lens    => 'Samba.lns',
    context => $context,
    changes => "set ${target} global",
    require => Class['samba::server::config'],
    notify  => Class['samba::server::service']
  }

  samba::server::option {
    'bind interfaces only':       value => $bind_interfaces_only;
    'deadtime':                   value => $deadtime;
    'disable spoolss':            value => $disable_spoolss;
    'dns proxy':                  value => $dns_proxy;
    'guest account':              value => $guest_account;
    'keepalive':                  value => $keepalive;
    'kernel oplocks':             value => $kernel_oplocks;
    'load printers':              value => $load_printers;
    'log file':                   value => $log_file;
    'map to guest':               value => $map_to_guest;
    'max log size':               value => $max_log_size;
    'netbios name':               value => $netbios_name;
    'obey pam restrictions':      value => $obey_pam_restrictions;
    'os level':                   value => $os_level;
    'pam password change':        value => $pam_password_change;
    'panic action':               value => $panic_action;
    'passdb backend':             value => $passdb_backend;
    'passwd chat':                value => $passwd_chat;
    'passwd program':             value => $passwd_program;
    'preferred master':           value => $preferred_master;
    'printcap name':              value => $printcap_name;
    'printing':                   value => $printing;
    'security':                   value => $security;
    'server role':                value => $server_role;
    'server string':              value => $server_string;
    'socket options':             value => $socket_options;
    'syslog':                     value => $syslog;
    'unix password sync':         value => $unix_password_sync;
    'usershare allow guests':     value => $usershare_allow_guests;
    'workgroup':                  value => $workgroup;
    'interfaces':                 value => $interfaces;
  }

  create_resources(samba::server::share, $shares)
  create_resources(samba::server::user, $users)
}
