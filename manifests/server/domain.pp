class samba::server::domain($ensure = present,
  $domain_acct = undef,
  $domain_pass = undef,
  $password_server = undef,
  $passdb_backend = undef,
  $wins_server = undef,
  $local_master = undef
) {

  include samba::server::config

  samba::server::option {
    'password server':              value => $password_server;
    'passdb backend':               value => $passdb_backend;
    'wins server':                  value => $wins_server;
    'local master':                 value => $local_master;
  }

  exec {'join-domain':
    # join the domain configured in samba.conf
    command => "/usr/bin/net rpc join -S $password_server -U $domain_acct%$domain_pass",
    onlyif  => '/usr/bin/test ! $(/usr/bin/net rpc testjoin)',
    subscribe => Service['samba']
  }

}
