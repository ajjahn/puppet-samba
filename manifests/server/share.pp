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
  $config_file = $samba::params::samba_config_file
  $target      = "target[. = '${name}']"
  $context     = $samba::server::context

  augeas { "${name}-section":
    incl    => "${config_file}",
    lens    => 'Samba.lns',
    context => $context,
    changes => $ensure ? {
      present => "set ${target} '${name}'",
      default => "rm ${target} '${name}'",
    },
    require => Class['samba::server::config'],
    notify  => Class['samba::server::service']
  }

  if $ensure == 'present' {
    $changes = [
      $browsable ? {
        true    => "set \"${target}/browsable\" yes",
        false   => "set \"${target}/browsable\" no",
        default => "rm  \"${target}/browsable\"",
      },
      $comment ? {
        default => "set \"${target}/comment\" '${comment}'",
        ''      => "rm  \"${target}/comment\"",
      },
      $copy ? {
        default => "set \"${target}/copy\" '${copy}'",
        ''      => "rm  \"${target}/copy\"",
      },
      $create_mask ? {
        default => "set \"${target}/create mask\" '${create_mask}'",
        ''      => "rm  \"${target}/create mask\"",
      },
      $directory_mask ? {
        default => "set \"${target}/directory mask\" '${directory_mask}'",
        ''      => "rm  \"${target}/directory mask\"",
      },
      $force_create_mode ? {
        default => "set \"${target}/force create mode\" '${force_create_mode}'",
        ''      => "rm  \"${target}/force create mode\"",
      },
      $force_directory_mode ? {
        default => "set \"${target}/force directory mode\" '${force_directory_mode}'",
        ''      => "rm  \"${target}/force directory mode\"",
      },
      $force_group ? {
        default => "set \"${target}/force group\" '${force_group}'",
        ''      => "rm  \"${target}/force group\"",
      },
      $force_user ? {
        default => "set \"${target}/force user\" '${force_user}'",
        ''      => "rm  \"${target}/force user\"",
      },
      $guest_account ? {
        default => "set \"${target}/guest account\" '${guest_account}'",
        ''      => "rm  \"${target}/guest account\"",
      },
      $guest_ok ? {
        true    => "set \"${target}/guest ok\" yes",
        false   => "set \"${target}/guest ok\" no",
        default => "rm  \"${target}/guest ok\"",
      },
      $guest_only ? {
        true    => "set \"${target}/guest only\" yes",
        false   => "set \"${target}/guest only\" no",
        default => "rm  \"${target}/guest only\"",
      },
      $path ? {
        default => "set ${target}/path '${path}'",
        ''      => "rm  ${target}/path",
      },
      $read_only ? {
        true    => "set \"${target}/read only\" yes",
        false   => "set \"${target}/read only\" no",
        default => "rm  \"${target}/read_only\"",
      },
      $public ? {
        true    => "set \"${target}/public\" yes",
        false   => "set \"${target}/public\" no",
        default => "rm  \"${target}/public\"",
      },
      $writable ? {
        true    => "set \"${target}/writable\" yes",
        false   => "set \"${target}/writable\" no",
        default => "rm  \"${target}/writable\"",
      },
      $printable ? {
        true    => "set \"${target}/printable\" yes",
        false   => "set \"${target}/printable\" no",
        default => "rm  \"${target}/printable\"",
      },
      $wide_links ? {
        true    => "set \"${target}/wide links\" yes",
        false   => "set \"${target}/wide links\" no",
        default => "rm  \"${target}/wide links\"",
      },
      $follow_symlinks ? {
        true    => "set \"${target}/follow symlinks\" yes",
        false   => "set \"${target}/follow symlinks\" no",
        default => "rm  \"${target}/follow symlinks\"",
      },
      $valid_users ? {
        default => "set \"${target}/valid users\" '${valid_users}'",
        ''      => "rm  \"${target}/valid users\"",
      },
    ]

    augeas { "${name}-changes":
      incl    => "${config_file}",
      lens    => 'Samba.lns',
      context => $context,
      changes => $changes,
      require => Augeas["${name}-section"],
      notify  => Class['samba::server::service']
    }
  }
}

