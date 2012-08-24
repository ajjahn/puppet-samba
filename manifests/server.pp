class samba::server($workgroup = pcch) {
	include samba::server::install
	include samba::server::config
	include samba::server::service

  $context = "/files/etc/samba/smb.conf"
  $target = "target[. = 'global']"

  augeas { 'global-section':
    context => $context,
    changes => "set ${target} global",
    require => Class["samba::server::config"]
  }

  augeas { 'global-workgroup':
    context => $context,
    changes => $workgroup ? {
      default => "set ${target}/workgroup $workgroup",
      '' => "rm ${target}/workgroup",
    },
    require => Augeas['global-section'],
  }

}
