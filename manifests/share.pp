define samba::share($ensure = present,
                    $description = '',
                    $path = '',
                    $browsable = '',
                    $guestok = '',
                    $readonly = '') {
  
  $context = "/files/etc/samba/smb.conf"
  $target = "target[. = '${name}']"

  augeas { "${name}-section":
    context => $context,
    changes => $ensure ? {
      present => "set ${target} ${name}",
      default => "rm ${target} ${name}",
    },
    require => Class["samba::server::config"]
  }

  if $ensure == "present" {
    augeas { "${name}-comment":
      context => $context,
      changes => $description ? {
        default => "set ${target}/comment ${description}",
        '' => "rm ${target}/comment",
      },
      require => Augeas["${name}-section"],
    }

    augeas { "${name}-path":
      context => $context,
      changes => $path ? {
        default => "set ${target}/path ${path}",
        '' => "rm ${target}/path",
      },
      require => Augeas["${name}-section"],
    }

    augeas { "${name}-browsable":
      context => $context,
      changes => $browsable ? {
        default => "set ${target}/browsable ${browsable}",
        '' => "rm ${target}/browsable",
      },
      require => Augeas["${name}-section"],
    }

    augeas { "${name}-guestok":
      context => $context,
      changes => $guestok ? {
        default => "set ${target}/guestok ${guestok}",
        '' => "rm ${target}/guestok",
      },
      require => Augeas["${name}-section"],
    }
    
    augeas { "${name}-readonly":
      context => $context,
      changes => $readonly ? {
        default => "set ${target}/readonly ${readonly}",
        '' => "rm ${target}/readonly",
      },
      require => Augeas["${name}-section"],
    }
  }
}
