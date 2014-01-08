define samba::server::share($ensure = present,
                            $browsable = '',
                            $comment = '',
                            $copy = '',
                            $create_mask = '',
                            $directory_mask = '',
                            $force_create_mode = '',
                            $force_directory_mode = '',
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
                            $wide_links = '',
                            $follow_symlinks = '',
                            $valid_users = '') {

  $context     = $samba::server::context
  $config_file = $samba::params::samba_config_file
  $lense       = $samba::params::lense
  $target      = "target[. = '${name}']"

  augeas { "${name}-section":
    context => $context,
    changes => $ensure ? {
      present => "set ${target} '${name}'",
      default => "rm ${target} '${name}'",
    },
    incl    => "${config_file}",
    lens    => "${lense}",
    require => Class['samba::server::config'],
    notify  => Class['samba::server::service']
  }

  if $ensure == present {
    augeas { "${name}-browsable":
      context => $context,
      changes => $browsable ? {
        true    => "set ${target}/browsable yes",
        false   => "set ${target}/browsable no",
        default => "rm ${target}/browsable",
      },
      incl    => "${config_file}",
      lens    => "${lense}",
      require => Augeas["${name}-section"],
      notify  => Class['samba::server::service']
    }

    augeas { "${name}-comment":
      context => $context,
      changes => $comment ? {
        default => "set ${target}/comment '${comment}'",
        ''      => "rm ${target}/comment",
      },
      incl    => "${config_file}",
      lens    => "${lense}",
      require => Augeas["${name}-section"],
      notify  => Class['samba::server::service']
    }

    augeas { "${name}-copy":
      context => $context,
      changes => $copy ? {
        default => "set ${target}/copy '${copy}'",
        ''      => "rm ${target}/copy",
      },
      incl    => "${config_file}",
      lens    => "${lense}",
      require => Augeas["${name}-section"],
      notify  => Class['samba::server::service']
    }

    augeas { "${name}-create_mask":
      context => $context,
      changes => $create_mask ? {
        default => "set \"${target}/create mask\" '${create_mask}'",
        ''      => "rm \"${target}/create mask\"",
      },
      incl    => "${config_file}",
      lens    => "${lense}",
      require => Augeas["${name}-section"],
      notify  => Class['samba::server::service']
    }

    augeas { "${name}-directory_mask":
      context => $context,
      changes => $directory_mask ? {
        default => "set \"${target}/directory mask\" '${directory_mask}'",
        ''      => "rm \"${target}/directory mask\"",
      },
      incl    => "${config_file}",
      lens    => "${lense}",
      require => Augeas["${name}-section"],
      notify  => Class['samba::server::service']
    }

    augeas { "${name}-force_create_mode":
      context => $context,
      changes => $force_create_mode ? {
        default => "set \"${target}/force create mode\" '${force_create_mode}'",
        ''      => "rm \"${target}/force create mode\"",
      },
      incl    => "${config_file}",
      lens    => "${lense}",
      require => Augeas["${name}-section"],
      notify  => Class['samba::server::service']
    }

    augeas { "${name}-force_directory_mode":
      context => $context,
      changes => $force_directory_mode ? {
        default => "set \"${target}/force directory mode\" '${force_directory_mode}'",
        ''      => "rm \"${target}/force directory mode\"",
      },
      incl    => "${config_file}",
      lens    => "${lense}",
      require => Augeas["${name}-section"],
      notify  => Class['samba::server::service']
    }

    augeas { "${name}-force_group":
      context => $context,
      changes => $force_group ? {
        default => "set \"${target}/force group\" '${force_group}'",
        ''      => "rm \"${target}/force group\"",
      },
      incl    => "${config_file}",
      lens    => "${lense}",
      require => Augeas["${name}-section"],
      notify  => Class['samba::server::service']
    }

    augeas { "${name}-force_user":
      context => $context,
      changes => $force_user ? {
        default => "set \"${target}/force user\" '${force_user}'",
        ''      => "rm \"${target}/force user\"",
      },
      incl    => "${config_file}",
      lens    => "${lense}",
      require => Augeas["${name}-section"],
      notify  => Class['samba::server::service']
    }

    augeas { "${name}-guest_account":
      context => $context,
      changes => $guest_account ? {
        default => "set \"${target}/guest account\" '${guest_account}'",
        ''      => "rm \"${target}/guest account\"",
      },
      incl    => "${config_file}",
      lens    => "${lense}",
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
      incl    => "${config_file}",
      lens    => "${lense}",
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
      incl    => "${config_file}",
      lens    => "${lense}",
      require => Augeas["${name}-section"],
      notify  => Class['samba::server::service']
    }

    augeas { "${name}-path":
      context => $context,
      changes => $path ? {
        default => "set ${target}/path '${path}'",
        ''      => "rm ${target}/path",
      },
      incl    => "${config_file}",
      lens    => "${lense}",
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
      incl    => "${config_file}",
      lens    => "${lense}",
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
      incl    => "${config_file}",
      lens    => "${lense}",
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
      incl    => "${config_file}",
      lens    => "${lense}",
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
      incl    => "${config_file}",
      lens    => "${lense}",
      require => Augeas["${name}-section"],
      notify  => Class['samba::server::service']
    }

    augeas { "${name}-wide-links":
      context => $context,
      changes => $wide_links ? {
        true    => "set \"${target}/wide links\" yes",
        false   => "set \"${target}/wide links\" no",
        default => "rm \"${target}/wide links\"",
      },
      incl    => "${config_file}",
      lens    => "${lense}",
      require => Augeas["${name}-section"],
      notify  => Class['samba::server::service']
    }

    augeas { "${name}-follow-symlinks":
      context => $context,
      changes => $follow_symlinks ? {
        true    => "set \"${target}/follow symlinks\" yes",
        false   => "set \"${target}/follow symlinks\" no",
        default => "rm \"${target}/follow symlinks\"",
      },
      incl    => "${config_file}",
      lens    => "${lense}",
      require => Augeas["${name}-section"],
      notify  => Class['samba::server::service']
    }

    augeas { "${name}-valid-users":
      context => $context,
      changes => $valid_users ? {
        default => "set \"${target}/valid users\" '${valid_users}'",
        ''      => "rm \"${target}/valid users\"",
      },
      incl    => "${config_file}",
      lens    => "${lense}",
      require => Augeas["${name}-section"],
      notify  => Class['samba::server::service']
    }
  }
}

