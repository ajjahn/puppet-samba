# Puppet Samba Module

[![Build Status](https://travis-ci.org/ajjahn/puppet-samba.png?branch=master)](https://travis-ci.org/ajjahn/puppet-samba)

Module for provisioning Samba

Supports:

* Ubuntu: 14.04, 12.04, 16.04 LTS 
* Debian: 8.x, 7.x
* CentOS: 7.x, 6.x

Patches to support other operating systems are welcome.

## Installation

Clone this repo to your Puppet modules directory

    git clone git://github.com/ajjahn/puppet-samba.git samba

or

    puppet module install ajjahn/samba

## Usage

Tweak and add the following to your site manifest:

```puppet
node 'server.example.com' {
  class {'samba::server':
        workgroup               => 'WORKGROUP',
        server_string           => "${::hostname}",
        dns_proxy               => 'no',
        log_file                => '/var/log/samba/log.%m',
        max_log_size            => '1000',
        syslog                  => '0',
        panic_action            => '/usr/share/samba/panic-action %d',
        server_role             => 'standalone server',
        passdb_backend          => 'tdbsam',
        obey_pam_restrictions   => 'yes',
        unix_password_sync      => 'yes',
        passwd_program          => '/usr/bin/passwd %u',
        passwd_chat             => '*Enter\snew\s*\spassword:* %n\n *Retype\snew\s*\spassword:* %n\n *password\supdated\ssuccessfully* .',
        pam_password_change     => 'yes',
        map_to_guest            => 'Never',
        usershare_allow_guests  => 'yes',
        #interfaces             => "eth0 lo",
        bind_interfaces_only    => 'no',
        security                => 'user',
  }

  samba::server::share {'example-share':
    comment                   => 'Example Share',
    path                      => '/path/to/share',
    guest_only                => true,
    guest_ok                  => true,
    guest_account             => "guest",
    browsable                 => false,
    create_mask               => 0777,
    force_create_mask         => 0777,
    directory_mask            => 0777,
    force_directory_mask      => 0777,
    force_group               => 'group',
    force_user                => 'user',
    copy                      => 'some-other-share',
    hosts_allow               => '127.0.0.1, 192.168.0.1'
    acl_allow_execute_always  => true,
  }
}
```

If you want join Samba server to Active Directory.

```puppet
node 'server.example.com' {
  class {'samba::server':
    workgroup => 'example',
    server_string => "Example Samba Server",
    interfaces => "eth0 lo",
    security => 'ads'
  }

  samba::server::share {'ri-storage':
    comment           => 'RBTH User Storage',
    path              => "$smb_share",
    browsable         => true,
    writable          => true,
    create_mask       => 0770,
    directory_mask    => 0770,
  }

  class { 'samba::server::ads':
      winbind_acct    => $::domain_admin,
      winbind_pass    => $::admin_password,
      realm           => 'EXAMPLE.COM',
      nsswitch        => true,
      target_ou       => "Nix_Mashine"
  }
}
```

Most configuration options are optional.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

This module is released under the MIT license:

* [http://www.opensource.org/licenses/MIT](http://www.opensource.org/licenses/MIT)
