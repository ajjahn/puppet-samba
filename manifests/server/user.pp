define samba::server::user(
		$user_name = $name ,
		$password ,
	) {
		exec { "add smb account for ${user_name}":
			command => "/sbin/add_samba_user '${user_name}' '${password}'" ,
			unless => "/sbin/check_samba_user '${user_name}'" ,
			require => [
				User["${user_name}"]
			] ,
			notify  => Class['samba::server::service']
	}
}
