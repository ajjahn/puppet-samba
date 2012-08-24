class samba::server($workgroup = PCCH) {
	include samba::server::install
	include samba::server::config
	include samba::server::service

  $target = "target[. = 'global']"

  augeas { global:
    context => "/files/etc/samba/smb.conf",
    changes => [
      "set ${target} global",
      "set ${target}/workgroup $workgroup"
    ],
    require => Class["samba::server::config"]
  }
}
