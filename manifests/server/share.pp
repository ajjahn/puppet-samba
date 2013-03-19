define samba::server::share($ensure = present,
                            $browsable = '',
                            $comment = '',
                            $copy = '',
                            $create_mask = '',
                            $directory_mask = '',
                            $force_create_mask = '',
                            $force_directory_mask = '',
                            $force_group = '',
                            $force_user = '',
                            $guest_account = '',
                            $guest_ok = '',
                            $guest_only = '',
                            $path = '',
                            $read_only = '',
                            $public = '',
                            $writable = '',
                            $printable = '',
  ) {

  $context = '/files/etc/samba/smb.conf'
  $target = "target[. = '${name}']"

  augeas { "${name}-section":
    context => $context,
    changes => $ensure ? {
      present => "set ${target} '${name}'",
      default => "rm ${target} '${name}'",
    },
    require => Class['samba::server::config'],
    notify  => Class['samba::server::service']
  }

  if $ensure == 'present' {
    augeas { "${name}-browsable":
      context => $context,
      changes => $browsable ? {
        true    => "set ${target}/browsable yes",
        false   => "set ${target}/browsable no",
        default => "rm ${target}/browsable",
      },
      require => Augeas["${name}-section"],
      notify  => Class['samba::server::service']
    }

    augeas { "${name}-comment":
      context => $context,
      changes => $comment ? {
        default => "set ${target}/comment '${comment}'",
        ''      => "rm ${target}/comment",
      },
      require => Augeas["${name}-section"],
      notify  => Class['samba::server::service']
    }

    augeas { "${name}-copy":
      context => $context,
      changes => $copy ? {
        default => "set ${target}/copy '${copy}'",
        ''      => "rm ${target}/copy",
      },
      require => Augeas["${name}-section"],
      notify  => Class['samba::server::service']
    }

    augeas { "${name}-create_mask":
      context => $context,
      changes => $create_mask ? {
        default => "set \"${target}/create mask\" '${create_mask}'",
        ''      => "rm \"${target}/create mask\"",
      },
      require => Augeas["${name}-section"],
      notify  => Class['samba::server::service']
    }

    augeas { "${name}-directory_mask":
      context => $context,
      changes => $directory_mask ? {
        default => "set \"${target}/directory mask\" '${directory_mask}'",
        ''      => "rm \"${target}/directory mask\"",
      },
      require => Augeas["${name}-section"],
      notify  => Class['samba::server::service']
    }

    augeas { "${name}-force_create_mask":
      context => $context,
      changes => $force_create_mask ? {
        default => "set \"${target}/force create mask\" '${force_create_mask}'",
        ''      => "rm \"${target}/force create mask\"",
      },
      require => Augeas["${name}-section"],
      notify  => Class['samba::server::service']
    }

    augeas { "${name}-force_directory_mask":
      context => $context,
      changes => $force_directory_mask ? {
        default => "set \"${target}/force directory mask\" '${force_directory_mask}'",
        ''      => "rm \"${target}/force directory mask\"",
      },
      require => Augeas["${name}-section"],
      notify  => Class['samba::server::service']
    }

    augeas { "${name}-force_group":
      context => $context,
      changes => $force_group ? {
        default => "set \"${target}/force group\" '${force_group}'",
        ''      => "rm \"${target}/force group\"",
      },
      require => Augeas["${name}-section"],
      notify  => Class['samba::server::service']
    }

    augeas { "${name}-force_user":
      context => $context,
      changes => $force_user ? {
        default => "set \"${target}/force user\" '${force_user}'",
        ''      => "rm \"${target}/force user\"",
      },
      require => Augeas["${name}-section"],
      notify  => Class['samba::server::service']
    }

    augeas { "${name}-guest_account":
      context => $context,
      changes => $guest_account ? {
        default => "set \"${target}/guest account\" '${guest_account}'",
        ''      => "rm \"${target}/guest account\"",
      },
      require => Augeas["${name}-section"],
      notify  => Class['samba::server::service']
    }

    augeas { "${name}-guest_ok":
      context => $context,
      changes => $guest_ok ? {
        true    => "set \"${target}/guest ok\" yes",
        false   => "set \"${target}/guest ok\" no",
        default => "rm \"${target}/guest ok\"",
      },
      require => Augeas["${name}-section"],
      notify  => Class['samba::server::service']
    }

    augeas { "${name}-guest_only":
      context => $context,
      changes => $guest_only ? {
        true    => "set \"${target}/guest only\" yes",
        false   => "set \"${target}/guest only\" no",
        default => "rm \"${target}/guest only\"",
      },
      require => Augeas["${name}-section"],
      notify  => Class['samba::server::service']
    }

    augeas { "${name}-path":
      context => $context,
      changes => $path ? {
        default => "set ${target}/path '${path}'",
        ''      => "rm ${target}/path",
      },
      require => Augeas["${name}-section"],
      notify  => Class['samba::server::service']
    }

    augeas { "${name}-read_only":
      context => $context,
      changes => $read_only ? {
        true    => "set \"${target}/read only\" yes",
        false   => "set \"${target}/read only\" no",
        default => "rm \"${target}/read_only\"",
      },
      require => Augeas["${name}-section"],
      notify  => Class['samba::server::service']
    }

    augeas { "${name}-public":
      context => $context,
      changes => $public ? {
        true    => "set \"${target}/public\" yes",
        false   => "set \"${target}/public\" no",
        default => "rm \"${target}/public\"",
      },
      require => Augeas["${name}-section"],
      notify  => Class['samba::server::service']
    }

    augeas { "${name}-writable":
      context => $context,
      changes => $writable ? {
        true    => "set \"${target}/writable\" yes",
        false   => "set \"${target}/writable\" no",
        default => "rm \"${target}/writable\"",
      },
      require => Augeas["${name}-section"],
      notify  => Class['samba::server::service']
    }

    augeas { "${name}-printable":
      context => $context,
      changes => $printable ? {
        true    => "set \"${target}/printable\" yes",
        false   => "set \"${target}/printable\" no",
        default => "rm \"${target}/printable\"",
      },
      require => Augeas["${name}-section"],
      notify  => Class['samba::server::service']
    }
  }
}
