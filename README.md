# Puppet Samba Module

Module for provisioning Samba

Tested on Ubuntu 12.04, CentOS 6.3, patches to support other operating systems are welcome.

## Installation

Clone this repo to your Puppet modules directory

    git clone git://github.com/ajjahn/puppet-samba.git samba

or

    puppet module install ajjahn/samba

## Usage

Tweak and add the following to your site manifest:

    node 'server.example.com' {
      class {'samba::server':
        workgroup => 'example',
        server_string => "Example Samba Server",
        interfaces => "eth0 lo",
        security => 'share'
      }

      samba::server::share {'example-share':
        comment => 'Example Share',
        path => '/path/to/share',
        guest_only => true,
        guest_ok => true,
        guest_account => "guest",
        browsable => false,
        create_mask => 0777,
        force_create_mask => 0777,
        directory_mask => 0777,
        force_directory_mask => 0777,
        force_group => 'group',
        force_user => 'user',
        copy => 'some-other-share',
      }
    }

If you want join Samba server to Active Directory. Tested on Ubuntu 12.04.
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
        writeable         => true,
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
