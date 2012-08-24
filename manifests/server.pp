class samba::server($workgroup = pcch) {
	include samba::server::install
	include samba::server::config
	include samba::server::service
  
  augeas { global:
      context => "/files/etc/samba/smb.conf",
      changes => [
        "set target[. = 'global']/workgroup $workgroup"
        ],
      require => Class["samba::server::config"]
    }
}