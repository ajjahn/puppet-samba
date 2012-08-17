define samba::share($ensure=present,
              $description,
              $path,
              $browsable,
              $mask,
              $guestok="no",
              $readonly="no" ) {
  
  $share = $name
  $context = "/files/etc/samba/smb.conf"
  $target = "target[. = '${name}']"

  augeas { "${share}":
    context => $context,
    changes => $ensure ? {
      present => [ "set ${target} ${name}",
                    "set ${target}/comment ${description}",
                    "set ${target}/path ${path}",
                    "set ${target}/browsable ${browsable}",
                    "set ${target}/mask ${mask}" ],
      default => ["rm ${target} ${name}"],
    },
    require => Class["samba::server::config"]
  }
  
}
