define samba::server::share($ensure = present,
                    $description = '',
                    $path = '',
                    $browsable = '',
                    $guest_ok = '',
                    $read_only = '') {

  $context = "/files/etc/samba/smb.conf"
  $target = "target[. = '${name}']"

  augeas { "${name}-section":
    context => $context,
    changes => $ensure ? {
      present => "set ${target} ${name}",
      default => "rm ${target} ${name}",
    },
    require => Class["samba::server::config"],
    notify => Class["samba::server::service"]
  }

  if $ensure == "present" {
    augeas { "${name}-comment":
      context => $context,
      changes => $description ? {
        default => "set ${target}/comment ${description}",
        '' => "rm ${target}/comment",
      },
      require => Augeas["${name}-section"],
      notify => Class["samba::server::service"]
    }

    augeas { "${name}-path":
      context => $context,
      changes => $path ? {
        default => "set ${target}/path ${path}",
        '' => "rm ${target}/path",
      },
      require => Augeas["${name}-section"],
      notify => Class["samba::server::service"]
    }

    augeas { "${name}-browsable":
      context => $context,
      changes => $browsable ? {
        default => "set ${target}/browsable ${browsable}",
        '' => "rm ${target}/browsable",
      },
      require => Augeas["${name}-section"],
      notify => Class["samba::server::service"]
    }

    augeas { "${name}-guest_ok":
      context => $context,
      changes => $guest_ok ? {
        default => "set \"${target}/guest ok\" ${guest_ok}",
        '' => "rm \"${target}/guest ok\"",
      },
      require => Augeas["${name}-section"],
      notify => Class["samba::server::service"]
    }

    augeas { "${name}-read_only":
      context => $context,
      changes => $read_only ? {
        default => "set \"${target}/read only\" ${read_only}",
        '' => "rm \"${target}/read_only\"",
      },
      require => Augeas["${name}-section"],
      notify => Class["samba::server::service"]
    }
  }
}
