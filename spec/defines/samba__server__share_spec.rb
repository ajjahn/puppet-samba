require 'spec_helper'

describe 'samba::server::share', :type => :define do
  let(:pre_condition){ 'class{"samba::server":}'}
  on_supported_os({
      :hardwaremodels => ['x86_64'],
      :supported_os   => [
        {
          "operatingsystem" => "Ubuntu",
          "operatingsystemrelease" => [
            "14.04"
          ]
        },
        {
          "operatingsystem" => "CentOS",
          "operatingsystemrelease" => [
            "7"
          ]
        }
      ],
    }).each do |os, facts|
    context "When on an #{os} system" do
      let(:facts) do
        facts.merge({
          :concat_basedir => '/tmp',
          :domain => 'domain.com'
        })
      end

      context 'when called with base options' do
        let(:title) { 'test_share' }
        let(:params) {{
          :ensure => 'present'
        }}

        it { is_expected.to contain_samba__server__share('test_share') }
        it { is_expected.to contain_augeas('test_share-section').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => ["set target[. = 'test_share'] 'test_share'"],
          :require => 'Class[Samba::Server::Config]',
          :notify  => 'Class[Samba::Server::Service]')
        }
        it { is_expected.to contain_augeas('test_share-changes').with(
          :incl     => '/etc/samba/smb.conf',
          :lens     => 'Samba.lns',
          :context  => '/files/etc/samba/smb.conf',
          :require  => 'Augeas[test_share-section]',
          :notify   => 'Class[Samba::Server::Service]')
        }
      end#no params

      context 'when called with ensure set to absent' do
        let(:title) { 'test_share' }
        let(:params) {{
          :ensure => 'absent'
        }}

        it { is_expected.to contain_augeas('test_share-section').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => ["rm target[. = 'test_share'] 'test_share'"],
          :require => 'Class[Samba::Server::Config]',
          :notify  => 'Class[Samba::Server::Service]')
        }
      end#no params

      context 'when called with available set to true' do
        let(:title) { 'test_share' }
        let(:params) {{
          :ensure    => 'present',
          :available => true,
        }}
        it { is_expected.to contain_samba__server__share('test_share') }
        it { is_expected.to contain_augeas('test_share-section').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => ["set target[. = 'test_share'] 'test_share'"],
          :require => 'Class[Samba::Server::Config]',
          :notify  => 'Class[Samba::Server::Service]')
        }
        it { is_expected.to contain_augeas('test_share-changes').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => [
            "set \"target[. = 'test_share']/available\" yes",
            "rm  \"target[. = 'test_share']/browsable\"",
            "rm  \"target[. = 'test_share']/comment\"",
            "rm  \"target[. = 'test_share']/copy\"",
            "rm  \"target[. = 'test_share']/create mask\"",
            "rm  \"target[. = 'test_share']/directory mask\"",
            "rm  \"target[. = 'test_share']/force create mask\"",
            "rm  \"target[. = 'test_share']/force directory mode\"",
            "rm  \"target[. = 'test_share']/force group\"",
            "rm  \"target[. = 'test_share']/force user\"",
            "rm  \"target[. = 'test_share']/guest ok\"",
            "rm  \"target[. = 'test_share']/guest only\"",
            "rm  \"target[. = 'test_share']/hide unreadable\"",
            "rm  target[. = 'test_share']/path",
            "rm  \"target[. = 'test_share']/read only\"",
            "rm  \"target[. = 'test_share']/public\"",
            "rm  \"target[. = 'test_share']/writable\"",
            "rm  \"target[. = 'test_share']/printable\"",
            "rm  \"target[. = 'test_share']/follow symlinks\"",
            "rm  \"target[. = 'test_share']/wide links\"",
            "rm  \"target[. = 'test_share']/map acl inherit\"",
            "rm  \"target[. = 'test_share']/store dos attributes\"",
            "rm  \"target[. = 'test_share']/strict allocate\"",
            "rm  \"target[. = 'test_share']/valid users\"",
            "rm  \"target[. = 'test_share']/oplocks\"",
            "rm  \"target[. = 'test_share']/level2 oplocks\"",
            "rm  \"target[. = 'test_share']/veto oplock files\"",
            "rm  \"target[. = 'test_share']/write list\"",
            "rm  \"target[. = 'test_share']/hide dot files\"",
            "rm  \"target[. = 'test_share']/root preexec\""
          ],
          :require => 'Augeas[test_share-section]',
          :notify  => 'Class[Samba::Server::Service]')
        }
      end#available true

      context 'when called with available set to false' do
        let(:title) { 'test_share' }
        let(:params) {{
          :ensure    => 'present',
          :available => false,
        }}
        it { is_expected.to contain_samba__server__share('test_share') }
        it { is_expected.to contain_augeas('test_share-section').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => ["set target[. = 'test_share'] 'test_share'"],
          :require => 'Class[Samba::Server::Config]',
          :notify  => 'Class[Samba::Server::Service]')
        }
        it { is_expected.to contain_augeas('test_share-changes').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => [
            "set \"target[. = 'test_share']/available\" no",
            "rm  \"target[. = 'test_share']/browsable\"",
            "rm  \"target[. = 'test_share']/comment\"",
            "rm  \"target[. = 'test_share']/copy\"",
            "rm  \"target[. = 'test_share']/create mask\"",
            "rm  \"target[. = 'test_share']/directory mask\"",
            "rm  \"target[. = 'test_share']/force create mask\"",
            "rm  \"target[. = 'test_share']/force directory mode\"",
            "rm  \"target[. = 'test_share']/force group\"",
            "rm  \"target[. = 'test_share']/force user\"",
            "rm  \"target[. = 'test_share']/guest ok\"",
            "rm  \"target[. = 'test_share']/guest only\"",
            "rm  \"target[. = 'test_share']/hide unreadable\"",
            "rm  target[. = 'test_share']/path",
            "rm  \"target[. = 'test_share']/read only\"",
            "rm  \"target[. = 'test_share']/public\"",
            "rm  \"target[. = 'test_share']/writable\"",
            "rm  \"target[. = 'test_share']/printable\"",
            "rm  \"target[. = 'test_share']/follow symlinks\"",
            "rm  \"target[. = 'test_share']/wide links\"",
            "rm  \"target[. = 'test_share']/map acl inherit\"",
            "rm  \"target[. = 'test_share']/store dos attributes\"",
            "rm  \"target[. = 'test_share']/strict allocate\"",
            "rm  \"target[. = 'test_share']/valid users\"",
            "rm  \"target[. = 'test_share']/oplocks\"",
            "rm  \"target[. = 'test_share']/level2 oplocks\"",
            "rm  \"target[. = 'test_share']/veto oplock files\"",
            "rm  \"target[. = 'test_share']/write list\"",
            "rm  \"target[. = 'test_share']/hide dot files\"",
            "rm  \"target[. = 'test_share']/root preexec\""
          ],
          :require => 'Augeas[test_share-section]',
          :notify  => 'Class[Samba::Server::Service]')
        }
      end#available false

      context 'when called with browsable set to true' do
        let(:title) { 'test_share' }
        let(:params) {{
          :ensure    => 'present',
          :browsable => true,
        }}
        it { is_expected.to contain_samba__server__share('test_share') }
        it { is_expected.to contain_augeas('test_share-section').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => ["set target[. = 'test_share'] 'test_share'"],
          :require => 'Class[Samba::Server::Config]',
          :notify  => 'Class[Samba::Server::Service]')
        }
        it { is_expected.to contain_augeas('test_share-changes').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => [
            "rm  \"target[. = 'test_share']/available\"",
            "set \"target[. = 'test_share']/browsable\" yes",
            "rm  \"target[. = 'test_share']/comment\"",
            "rm  \"target[. = 'test_share']/copy\"",
            "rm  \"target[. = 'test_share']/create mask\"",
            "rm  \"target[. = 'test_share']/directory mask\"",
            "rm  \"target[. = 'test_share']/force create mask\"",
            "rm  \"target[. = 'test_share']/force directory mode\"",
            "rm  \"target[. = 'test_share']/force group\"",
            "rm  \"target[. = 'test_share']/force user\"",
            "rm  \"target[. = 'test_share']/guest ok\"",
            "rm  \"target[. = 'test_share']/guest only\"",
            "rm  \"target[. = 'test_share']/hide unreadable\"",
            "rm  target[. = 'test_share']/path",
            "rm  \"target[. = 'test_share']/read only\"",
            "rm  \"target[. = 'test_share']/public\"",
            "rm  \"target[. = 'test_share']/writable\"",
            "rm  \"target[. = 'test_share']/printable\"",
            "rm  \"target[. = 'test_share']/follow symlinks\"",
            "rm  \"target[. = 'test_share']/wide links\"",
            "rm  \"target[. = 'test_share']/map acl inherit\"",
            "rm  \"target[. = 'test_share']/store dos attributes\"",
            "rm  \"target[. = 'test_share']/strict allocate\"",
            "rm  \"target[. = 'test_share']/valid users\"",
            "rm  \"target[. = 'test_share']/oplocks\"",
            "rm  \"target[. = 'test_share']/level2 oplocks\"",
            "rm  \"target[. = 'test_share']/veto oplock files\"",
            "rm  \"target[. = 'test_share']/write list\"",
            "rm  \"target[. = 'test_share']/hide dot files\"",
            "rm  \"target[. = 'test_share']/root preexec\""
          ],
          :require => 'Augeas[test_share-section]',
          :notify  => 'Class[Samba::Server::Service]')
        }
      end#browsable false

      context 'when called with browsable set to false' do
        let(:title) { 'test_share' }
        let(:params) {{
          :ensure    => 'present',
          :browsable => false,
        }}
        it { is_expected.to contain_samba__server__share('test_share') }
        it { is_expected.to contain_augeas('test_share-section').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => ["set target[. = 'test_share'] 'test_share'"],
          :require => 'Class[Samba::Server::Config]',
          :notify  => 'Class[Samba::Server::Service]')
        }
        it { is_expected.to contain_augeas('test_share-changes').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => [
            "rm  \"target[. = 'test_share']/available\"",
            "set \"target[. = 'test_share']/browsable\" no",
            "rm  \"target[. = 'test_share']/comment\"",
            "rm  \"target[. = 'test_share']/copy\"",
            "rm  \"target[. = 'test_share']/create mask\"",
            "rm  \"target[. = 'test_share']/directory mask\"",
            "rm  \"target[. = 'test_share']/force create mask\"",
            "rm  \"target[. = 'test_share']/force directory mode\"",
            "rm  \"target[. = 'test_share']/force group\"",
            "rm  \"target[. = 'test_share']/force user\"",
            "rm  \"target[. = 'test_share']/guest ok\"",
            "rm  \"target[. = 'test_share']/guest only\"",
            "rm  \"target[. = 'test_share']/hide unreadable\"",
            "rm  target[. = 'test_share']/path",
            "rm  \"target[. = 'test_share']/read only\"",
            "rm  \"target[. = 'test_share']/public\"",
            "rm  \"target[. = 'test_share']/writable\"",
            "rm  \"target[. = 'test_share']/printable\"",
            "rm  \"target[. = 'test_share']/follow symlinks\"",
            "rm  \"target[. = 'test_share']/wide links\"",
            "rm  \"target[. = 'test_share']/map acl inherit\"",
            "rm  \"target[. = 'test_share']/store dos attributes\"",
            "rm  \"target[. = 'test_share']/strict allocate\"",
            "rm  \"target[. = 'test_share']/valid users\"",
            "rm  \"target[. = 'test_share']/oplocks\"",
            "rm  \"target[. = 'test_share']/level2 oplocks\"",
            "rm  \"target[. = 'test_share']/veto oplock files\"",
            "rm  \"target[. = 'test_share']/write list\"",
            "rm  \"target[. = 'test_share']/hide dot files\"",
            "rm  \"target[. = 'test_share']/root preexec\""
          ],
          :require => 'Augeas[test_share-section]',
          :notify  => 'Class[Samba::Server::Service]')
        }
      end#browsable false

      context 'when called with root_preexec set to /bin/true' do
        let(:title) { 'test_share' }
        let(:params) {{
          :ensure    => 'present',
          :root_preexec => '/bin/true',
        }}
        it { is_expected.to contain_samba__server__share('test_share') }
        it { is_expected.to contain_augeas('test_share-section').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => ["set target[. = 'test_share'] 'test_share'"],
          :require => 'Class[Samba::Server::Config]',
          :notify  => 'Class[Samba::Server::Service]')
        }
        it { is_expected.to contain_augeas('test_share-changes').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => [
            "rm  \"target[. = 'test_share']/available\"",
            "rm  \"target[. = 'test_share']/browsable\"",
            "rm  \"target[. = 'test_share']/comment\"",
            "rm  \"target[. = 'test_share']/copy\"",
            "rm  \"target[. = 'test_share']/create mask\"",
            "rm  \"target[. = 'test_share']/directory mask\"",
            "rm  \"target[. = 'test_share']/force create mask\"",
            "rm  \"target[. = 'test_share']/force directory mode\"",
            "rm  \"target[. = 'test_share']/force group\"",
            "rm  \"target[. = 'test_share']/force user\"",
            "rm  \"target[. = 'test_share']/guest ok\"",
            "rm  \"target[. = 'test_share']/guest only\"",
            "rm  \"target[. = 'test_share']/hide unreadable\"",
            "rm  target[. = 'test_share']/path",
            "rm  \"target[. = 'test_share']/read only\"",
            "rm  \"target[. = 'test_share']/public\"",
            "rm  \"target[. = 'test_share']/writable\"",
            "rm  \"target[. = 'test_share']/printable\"",
            "rm  \"target[. = 'test_share']/follow symlinks\"",
            "rm  \"target[. = 'test_share']/wide links\"",
            "rm  \"target[. = 'test_share']/map acl inherit\"",
            "rm  \"target[. = 'test_share']/store dos attributes\"",
            "rm  \"target[. = 'test_share']/strict allocate\"",
            "rm  \"target[. = 'test_share']/valid users\"",
            "rm  \"target[. = 'test_share']/oplocks\"",
            "rm  \"target[. = 'test_share']/level2 oplocks\"",
            "rm  \"target[. = 'test_share']/veto oplock files\"",
            "rm  \"target[. = 'test_share']/write list\"",
            "rm  \"target[. = 'test_share']/hide dot files\"",
            "set \"target[. = 'test_share']/root preexec\" '/bin/true'"
          ],
          :require => 'Augeas[test_share-section]',
          :notify  => 'Class[Samba::Server::Service]')
        }
      end#root_preexec

      context 'when called with comment set to "testing testing"' do
        let(:title) { 'test_share' }
        let(:params) {{
          :ensure    => 'present',
          :comment => 'testing testing',
        }}
        it { is_expected.to contain_samba__server__share('test_share') }
        it { is_expected.to contain_augeas('test_share-section').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => ["set target[. = 'test_share'] 'test_share'"],
          :require => 'Class[Samba::Server::Config]',
          :notify  => 'Class[Samba::Server::Service]')
        }
        it { is_expected.to contain_augeas('test_share-changes').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => [
            "rm  \"target[. = 'test_share']/available\"",
            "rm  \"target[. = 'test_share']/browsable\"",
            "set \"target[. = 'test_share']/comment\" 'testing testing'",
            "rm  \"target[. = 'test_share']/copy\"",
            "rm  \"target[. = 'test_share']/create mask\"",
            "rm  \"target[. = 'test_share']/directory mask\"",
            "rm  \"target[. = 'test_share']/force create mask\"",
            "rm  \"target[. = 'test_share']/force directory mode\"",
            "rm  \"target[. = 'test_share']/force group\"",
            "rm  \"target[. = 'test_share']/force user\"",
            "rm  \"target[. = 'test_share']/guest ok\"",
            "rm  \"target[. = 'test_share']/guest only\"",
            "rm  \"target[. = 'test_share']/hide unreadable\"",
            "rm  target[. = 'test_share']/path",
            "rm  \"target[. = 'test_share']/read only\"",
            "rm  \"target[. = 'test_share']/public\"",
            "rm  \"target[. = 'test_share']/writable\"",
            "rm  \"target[. = 'test_share']/printable\"",
            "rm  \"target[. = 'test_share']/follow symlinks\"",
            "rm  \"target[. = 'test_share']/wide links\"",
            "rm  \"target[. = 'test_share']/map acl inherit\"",
            "rm  \"target[. = 'test_share']/store dos attributes\"",
            "rm  \"target[. = 'test_share']/strict allocate\"",
            "rm  \"target[. = 'test_share']/valid users\"",
            "rm  \"target[. = 'test_share']/oplocks\"",
            "rm  \"target[. = 'test_share']/level2 oplocks\"",
            "rm  \"target[. = 'test_share']/veto oplock files\"",
            "rm  \"target[. = 'test_share']/write list\"",
            "rm  \"target[. = 'test_share']/hide dot files\"",
            "rm  \"target[. = 'test_share']/root preexec\""
          ],
          :require => 'Augeas[test_share-section]',
          :notify  => 'Class[Samba::Server::Service]')
        }
      end#comment

      context 'when called with copy set to "testing testing"' do
        let(:title) { 'test_share' }
        let(:params) {{
          :ensure    => 'present',
          :copy => 'testing testing',
        }}
        it { is_expected.to contain_samba__server__share('test_share') }
        it { is_expected.to contain_augeas('test_share-section').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => ["set target[. = 'test_share'] 'test_share'"],
          :require => 'Class[Samba::Server::Config]',
          :notify  => 'Class[Samba::Server::Service]')
        }
        it { is_expected.to contain_augeas('test_share-changes').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => [
            "rm  \"target[. = 'test_share']/available\"",
            "rm  \"target[. = 'test_share']/browsable\"",
            "rm  \"target[. = 'test_share']/comment\"",
            "set \"target[. = 'test_share']/copy\" 'testing testing'",
            "rm  \"target[. = 'test_share']/create mask\"",
            "rm  \"target[. = 'test_share']/directory mask\"",
            "rm  \"target[. = 'test_share']/force create mask\"",
            "rm  \"target[. = 'test_share']/force directory mode\"",
            "rm  \"target[. = 'test_share']/force group\"",
            "rm  \"target[. = 'test_share']/force user\"",
            "rm  \"target[. = 'test_share']/guest ok\"",
            "rm  \"target[. = 'test_share']/guest only\"",
            "rm  \"target[. = 'test_share']/hide unreadable\"",
            "rm  target[. = 'test_share']/path",
            "rm  \"target[. = 'test_share']/read only\"",
            "rm  \"target[. = 'test_share']/public\"",
            "rm  \"target[. = 'test_share']/writable\"",
            "rm  \"target[. = 'test_share']/printable\"",
            "rm  \"target[. = 'test_share']/follow symlinks\"",
            "rm  \"target[. = 'test_share']/wide links\"",
            "rm  \"target[. = 'test_share']/map acl inherit\"",
            "rm  \"target[. = 'test_share']/store dos attributes\"",
            "rm  \"target[. = 'test_share']/strict allocate\"",
            "rm  \"target[. = 'test_share']/valid users\"",
            "rm  \"target[. = 'test_share']/oplocks\"",
            "rm  \"target[. = 'test_share']/level2 oplocks\"",
            "rm  \"target[. = 'test_share']/veto oplock files\"",
            "rm  \"target[. = 'test_share']/write list\"",
            "rm  \"target[. = 'test_share']/hide dot files\"",
            "rm  \"target[. = 'test_share']/root preexec\""
          ],
          :require => 'Augeas[test_share-section]',
          :notify  => 'Class[Samba::Server::Service]')
        }
      end#copy

      context 'when called with create_mask set to "755"' do
        let(:title) { 'test_share' }
        let(:params) {{
          :ensure    => 'present',
          :create_mask => '755',
        }}
        it { is_expected.to contain_samba__server__share('test_share') }
        it { is_expected.to contain_augeas('test_share-section').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => ["set target[. = 'test_share'] 'test_share'"],
          :require => 'Class[Samba::Server::Config]',
          :notify  => 'Class[Samba::Server::Service]')
        }
        it { is_expected.to contain_augeas('test_share-changes').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => [
            "rm  \"target[. = 'test_share']/available\"",
            "rm  \"target[. = 'test_share']/browsable\"",
            "rm  \"target[. = 'test_share']/comment\"",
            "rm  \"target[. = 'test_share']/copy\"",
            "set \"target[. = 'test_share']/create mask\" '755'",
            "rm  \"target[. = 'test_share']/directory mask\"",
            "rm  \"target[. = 'test_share']/force create mask\"",
            "rm  \"target[. = 'test_share']/force directory mode\"",
            "rm  \"target[. = 'test_share']/force group\"",
            "rm  \"target[. = 'test_share']/force user\"",
            "rm  \"target[. = 'test_share']/guest ok\"",
            "rm  \"target[. = 'test_share']/guest only\"",
            "rm  \"target[. = 'test_share']/hide unreadable\"",
            "rm  target[. = 'test_share']/path",
            "rm  \"target[. = 'test_share']/read only\"",
            "rm  \"target[. = 'test_share']/public\"",
            "rm  \"target[. = 'test_share']/writable\"",
            "rm  \"target[. = 'test_share']/printable\"",
            "rm  \"target[. = 'test_share']/follow symlinks\"",
            "rm  \"target[. = 'test_share']/wide links\"",
            "rm  \"target[. = 'test_share']/map acl inherit\"",
            "rm  \"target[. = 'test_share']/store dos attributes\"",
            "rm  \"target[. = 'test_share']/strict allocate\"",
            "rm  \"target[. = 'test_share']/valid users\"",
            "rm  \"target[. = 'test_share']/oplocks\"",
            "rm  \"target[. = 'test_share']/level2 oplocks\"",
            "rm  \"target[. = 'test_share']/veto oplock files\"",
            "rm  \"target[. = 'test_share']/write list\"",
            "rm  \"target[. = 'test_share']/hide dot files\"",
            "rm  \"target[. = 'test_share']/root preexec\""
          ],
          :require => 'Augeas[test_share-section]',
          :notify  => 'Class[Samba::Server::Service]')
        }
      end#create mask

      context 'when called with directory_mask set to "755"' do
        let(:title) { 'test_share' }
        let(:params) {{
          :ensure    => 'present',
          :directory_mask => '755',
        }}
        it { is_expected.to contain_samba__server__share('test_share') }
        it { is_expected.to contain_augeas('test_share-section').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => ["set target[. = 'test_share'] 'test_share'"],
          :require => 'Class[Samba::Server::Config]',
          :notify  => 'Class[Samba::Server::Service]')
        }
        it { is_expected.to contain_augeas('test_share-changes').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => [
            "rm  \"target[. = 'test_share']/available\"",
            "rm  \"target[. = 'test_share']/browsable\"",
            "rm  \"target[. = 'test_share']/comment\"",
            "rm  \"target[. = 'test_share']/copy\"",
            "rm  \"target[. = 'test_share']/create mask\"",
            "set \"target[. = 'test_share']/directory mask\" '755'",
            "rm  \"target[. = 'test_share']/force create mask\"",
            "rm  \"target[. = 'test_share']/force directory mode\"",
            "rm  \"target[. = 'test_share']/force group\"",
            "rm  \"target[. = 'test_share']/force user\"",
            "rm  \"target[. = 'test_share']/guest ok\"",
            "rm  \"target[. = 'test_share']/guest only\"",
            "rm  \"target[. = 'test_share']/hide unreadable\"",
            "rm  target[. = 'test_share']/path",
            "rm  \"target[. = 'test_share']/read only\"",
            "rm  \"target[. = 'test_share']/public\"",
            "rm  \"target[. = 'test_share']/writable\"",
            "rm  \"target[. = 'test_share']/printable\"",
            "rm  \"target[. = 'test_share']/follow symlinks\"",
            "rm  \"target[. = 'test_share']/wide links\"",
            "rm  \"target[. = 'test_share']/map acl inherit\"",
            "rm  \"target[. = 'test_share']/store dos attributes\"",
            "rm  \"target[. = 'test_share']/strict allocate\"",
            "rm  \"target[. = 'test_share']/valid users\"",
            "rm  \"target[. = 'test_share']/oplocks\"",
            "rm  \"target[. = 'test_share']/level2 oplocks\"",
            "rm  \"target[. = 'test_share']/veto oplock files\"",
            "rm  \"target[. = 'test_share']/write list\"",
            "rm  \"target[. = 'test_share']/hide dot files\"",
            "rm  \"target[. = 'test_share']/root preexec\""
          ],
          :require => 'Augeas[test_share-section]',
          :notify  => 'Class[Samba::Server::Service]')
        }
      end#directory_mask

      context 'when called with force_create_mask set to "755"' do
        let(:title) { 'test_share' }
        let(:params) {{
          :ensure    => 'present',
          :force_create_mask => '755',
        }}
        it { is_expected.to contain_samba__server__share('test_share') }
        it { is_expected.to contain_augeas('test_share-section').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => ["set target[. = 'test_share'] 'test_share'"],
          :require => 'Class[Samba::Server::Config]',
          :notify  => 'Class[Samba::Server::Service]')
        }
        it { is_expected.to contain_augeas('test_share-changes').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => [
            "rm  \"target[. = 'test_share']/available\"",
            "rm  \"target[. = 'test_share']/browsable\"",
            "rm  \"target[. = 'test_share']/comment\"",
            "rm  \"target[. = 'test_share']/copy\"",
            "rm  \"target[. = 'test_share']/create mask\"",
            "rm  \"target[. = 'test_share']/directory mask\"",
            "set \"target[. = 'test_share']/force create mask\" '755'",
            "rm  \"target[. = 'test_share']/force directory mode\"",
            "rm  \"target[. = 'test_share']/force group\"",
            "rm  \"target[. = 'test_share']/force user\"",
            "rm  \"target[. = 'test_share']/guest ok\"",
            "rm  \"target[. = 'test_share']/guest only\"",
            "rm  \"target[. = 'test_share']/hide unreadable\"",
            "rm  target[. = 'test_share']/path",
            "rm  \"target[. = 'test_share']/read only\"",
            "rm  \"target[. = 'test_share']/public\"",
            "rm  \"target[. = 'test_share']/writable\"",
            "rm  \"target[. = 'test_share']/printable\"",
            "rm  \"target[. = 'test_share']/follow symlinks\"",
            "rm  \"target[. = 'test_share']/wide links\"",
            "rm  \"target[. = 'test_share']/map acl inherit\"",
            "rm  \"target[. = 'test_share']/store dos attributes\"",
            "rm  \"target[. = 'test_share']/strict allocate\"",
            "rm  \"target[. = 'test_share']/valid users\"",
            "rm  \"target[. = 'test_share']/oplocks\"",
            "rm  \"target[. = 'test_share']/level2 oplocks\"",
            "rm  \"target[. = 'test_share']/veto oplock files\"",
            "rm  \"target[. = 'test_share']/write list\"",
            "rm  \"target[. = 'test_share']/hide dot files\"",
            "rm  \"target[. = 'test_share']/root preexec\""
          ],
          :require => 'Augeas[test_share-section]',
          :notify  => 'Class[Samba::Server::Service]')
        }
      end#force_create_mask

      context 'when called with force_directory_mode set to "755"' do
        let(:title) { 'test_share' }
        let(:params) {{
          :ensure    => 'present',
          :force_directory_mode => '755',
        }}
        it { is_expected.to contain_samba__server__share('test_share') }
        it { is_expected.to contain_augeas('test_share-section').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => ["set target[. = 'test_share'] 'test_share'"],
          :require => 'Class[Samba::Server::Config]',
          :notify  => 'Class[Samba::Server::Service]')
        }
        it { is_expected.to contain_augeas('test_share-changes').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => [
            "rm  \"target[. = 'test_share']/available\"",
            "rm  \"target[. = 'test_share']/browsable\"",
            "rm  \"target[. = 'test_share']/comment\"",
            "rm  \"target[. = 'test_share']/copy\"",
            "rm  \"target[. = 'test_share']/create mask\"",
            "rm  \"target[. = 'test_share']/directory mask\"",
            "rm  \"target[. = 'test_share']/force create mask\"",
            "set \"target[. = 'test_share']/force directory mode\" '755'",
            "rm  \"target[. = 'test_share']/force group\"",
            "rm  \"target[. = 'test_share']/force user\"",
            "rm  \"target[. = 'test_share']/guest ok\"",
            "rm  \"target[. = 'test_share']/guest only\"",
            "rm  \"target[. = 'test_share']/hide unreadable\"",
            "rm  target[. = 'test_share']/path",
            "rm  \"target[. = 'test_share']/read only\"",
            "rm  \"target[. = 'test_share']/public\"",
            "rm  \"target[. = 'test_share']/writable\"",
            "rm  \"target[. = 'test_share']/printable\"",
            "rm  \"target[. = 'test_share']/follow symlinks\"",
            "rm  \"target[. = 'test_share']/wide links\"",
            "rm  \"target[. = 'test_share']/map acl inherit\"",
            "rm  \"target[. = 'test_share']/store dos attributes\"",
            "rm  \"target[. = 'test_share']/strict allocate\"",
            "rm  \"target[. = 'test_share']/valid users\"",
            "rm  \"target[. = 'test_share']/oplocks\"",
            "rm  \"target[. = 'test_share']/level2 oplocks\"",
            "rm  \"target[. = 'test_share']/veto oplock files\"",
            "rm  \"target[. = 'test_share']/write list\"",
            "rm  \"target[. = 'test_share']/hide dot files\"",
            "rm  \"target[. = 'test_share']/root preexec\""
          ],
          :require => 'Augeas[test_share-section]',
          :notify  => 'Class[Samba::Server::Service]')
        }
      end#force_directory_mode

      context 'when called with force_group set to "nogroup"' do
        let(:title) { 'test_share' }
        let(:params) {{
          :ensure    => 'present',
          :force_group => 'nogroup',
        }}
        it { is_expected.to contain_samba__server__share('test_share') }
        it { is_expected.to contain_augeas('test_share-section').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => ["set target[. = 'test_share'] 'test_share'"],
          :require => 'Class[Samba::Server::Config]',
          :notify  => 'Class[Samba::Server::Service]')
        }
        it { is_expected.to contain_augeas('test_share-changes').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => [
            "rm  \"target[. = 'test_share']/available\"",
            "rm  \"target[. = 'test_share']/browsable\"",
            "rm  \"target[. = 'test_share']/comment\"",
            "rm  \"target[. = 'test_share']/copy\"",
            "rm  \"target[. = 'test_share']/create mask\"",
            "rm  \"target[. = 'test_share']/directory mask\"",
            "rm  \"target[. = 'test_share']/force create mask\"",
            "rm  \"target[. = 'test_share']/force directory mode\"",
            "set \"target[. = 'test_share']/force group\" 'nogroup'",
            "rm  \"target[. = 'test_share']/force user\"",
            "rm  \"target[. = 'test_share']/guest ok\"",
            "rm  \"target[. = 'test_share']/guest only\"",
            "rm  \"target[. = 'test_share']/hide unreadable\"",
            "rm  target[. = 'test_share']/path",
            "rm  \"target[. = 'test_share']/read only\"",
            "rm  \"target[. = 'test_share']/public\"",
            "rm  \"target[. = 'test_share']/writable\"",
            "rm  \"target[. = 'test_share']/printable\"",
            "rm  \"target[. = 'test_share']/follow symlinks\"",
            "rm  \"target[. = 'test_share']/wide links\"",
            "rm  \"target[. = 'test_share']/map acl inherit\"",
            "rm  \"target[. = 'test_share']/store dos attributes\"",
            "rm  \"target[. = 'test_share']/strict allocate\"",
            "rm  \"target[. = 'test_share']/valid users\"",
            "rm  \"target[. = 'test_share']/oplocks\"",
            "rm  \"target[. = 'test_share']/level2 oplocks\"",
            "rm  \"target[. = 'test_share']/veto oplock files\"",
            "rm  \"target[. = 'test_share']/write list\"",
            "rm  \"target[. = 'test_share']/hide dot files\"",
            "rm  \"target[. = 'test_share']/root preexec\""
          ],
          :require => 'Augeas[test_share-section]',
          :notify  => 'Class[Samba::Server::Service]')
        }
      end#force_group

      context 'when called with force_user set to "nobody"' do
        let(:title) { 'test_share' }
        let(:params) {{
          :ensure    => 'present',
          :force_user => 'nobody',
        }}
        it { is_expected.to contain_samba__server__share('test_share') }
        it { is_expected.to contain_augeas('test_share-section').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => ["set target[. = 'test_share'] 'test_share'"],
          :require => 'Class[Samba::Server::Config]',
          :notify  => 'Class[Samba::Server::Service]')
        }
        it { is_expected.to contain_augeas('test_share-changes').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => [
            "rm  \"target[. = 'test_share']/available\"",
            "rm  \"target[. = 'test_share']/browsable\"",
            "rm  \"target[. = 'test_share']/comment\"",
            "rm  \"target[. = 'test_share']/copy\"",
            "rm  \"target[. = 'test_share']/create mask\"",
            "rm  \"target[. = 'test_share']/directory mask\"",
            "rm  \"target[. = 'test_share']/force create mask\"",
            "rm  \"target[. = 'test_share']/force directory mode\"",
            "rm  \"target[. = 'test_share']/force group\"",
            "set \"target[. = 'test_share']/force user\" 'nobody'",
            "rm  \"target[. = 'test_share']/guest ok\"",
            "rm  \"target[. = 'test_share']/guest only\"",
            "rm  \"target[. = 'test_share']/hide unreadable\"",
            "rm  target[. = 'test_share']/path",
            "rm  \"target[. = 'test_share']/read only\"",
            "rm  \"target[. = 'test_share']/public\"",
            "rm  \"target[. = 'test_share']/writable\"",
            "rm  \"target[. = 'test_share']/printable\"",
            "rm  \"target[. = 'test_share']/follow symlinks\"",
            "rm  \"target[. = 'test_share']/wide links\"",
            "rm  \"target[. = 'test_share']/map acl inherit\"",
            "rm  \"target[. = 'test_share']/store dos attributes\"",
            "rm  \"target[. = 'test_share']/strict allocate\"",
            "rm  \"target[. = 'test_share']/valid users\"",
            "rm  \"target[. = 'test_share']/oplocks\"",
            "rm  \"target[. = 'test_share']/level2 oplocks\"",
            "rm  \"target[. = 'test_share']/veto oplock files\"",
            "rm  \"target[. = 'test_share']/write list\"",
            "rm  \"target[. = 'test_share']/hide dot files\"",
            "rm  \"target[. = 'test_share']/root preexec\""
          ],
          :require => 'Augeas[test_share-section]',
          :notify  => 'Class[Samba::Server::Service]')
        }
      end#force_user

      context 'when called with guest_ok set to true' do
        let(:title) { 'test_share' }
        let(:params) {{
          :ensure   => 'present',
          :guest_ok => true,
        }}
        it { is_expected.to contain_samba__server__share('test_share') }
        it { is_expected.to contain_augeas('test_share-section').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => ["set target[. = 'test_share'] 'test_share'"],
          :require => 'Class[Samba::Server::Config]',
          :notify  => 'Class[Samba::Server::Service]')
        }
        it { is_expected.to contain_augeas('test_share-changes').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => [
            "rm  \"target[. = 'test_share']/available\"",
            "rm  \"target[. = 'test_share']/browsable\"",
            "rm  \"target[. = 'test_share']/comment\"",
            "rm  \"target[. = 'test_share']/copy\"",
            "rm  \"target[. = 'test_share']/create mask\"",
            "rm  \"target[. = 'test_share']/directory mask\"",
            "rm  \"target[. = 'test_share']/force create mask\"",
            "rm  \"target[. = 'test_share']/force directory mode\"",
            "rm  \"target[. = 'test_share']/force group\"",
            "rm  \"target[. = 'test_share']/force user\"",
            "set \"target[. = 'test_share']/guest ok\" yes",
            "rm  \"target[. = 'test_share']/guest only\"",
            "rm  \"target[. = 'test_share']/hide unreadable\"",
            "rm  target[. = 'test_share']/path",
            "rm  \"target[. = 'test_share']/read only\"",
            "rm  \"target[. = 'test_share']/public\"",
            "rm  \"target[. = 'test_share']/writable\"",
            "rm  \"target[. = 'test_share']/printable\"",
            "rm  \"target[. = 'test_share']/follow symlinks\"",
            "rm  \"target[. = 'test_share']/wide links\"",
            "rm  \"target[. = 'test_share']/map acl inherit\"",
            "rm  \"target[. = 'test_share']/store dos attributes\"",
            "rm  \"target[. = 'test_share']/strict allocate\"",
            "rm  \"target[. = 'test_share']/valid users\"",
            "rm  \"target[. = 'test_share']/oplocks\"",
            "rm  \"target[. = 'test_share']/level2 oplocks\"",
            "rm  \"target[. = 'test_share']/veto oplock files\"",
            "rm  \"target[. = 'test_share']/write list\"",
            "rm  \"target[. = 'test_share']/hide dot files\"",
            "rm  \"target[. = 'test_share']/root preexec\""
          ],
          :require => 'Augeas[test_share-section]',
          :notify  => 'Class[Samba::Server::Service]')
        }
      end#guest_ok true

      context 'when called with guest_ok set to false' do
        let(:title) { 'test_share' }
        let(:params) {{
          :ensure   => 'present',
          :guest_ok => false,
        }}
        it { is_expected.to contain_samba__server__share('test_share') }
        it { is_expected.to contain_augeas('test_share-section').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => ["set target[. = 'test_share'] 'test_share'"],
          :require => 'Class[Samba::Server::Config]',
          :notify  => 'Class[Samba::Server::Service]')
        }
        it { is_expected.to contain_augeas('test_share-changes').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => [
            "rm  \"target[. = 'test_share']/available\"",
            "rm  \"target[. = 'test_share']/browsable\"",
            "rm  \"target[. = 'test_share']/comment\"",
            "rm  \"target[. = 'test_share']/copy\"",
            "rm  \"target[. = 'test_share']/create mask\"",
            "rm  \"target[. = 'test_share']/directory mask\"",
            "rm  \"target[. = 'test_share']/force create mask\"",
            "rm  \"target[. = 'test_share']/force directory mode\"",
            "rm  \"target[. = 'test_share']/force group\"",
            "rm  \"target[. = 'test_share']/force user\"",
            "set \"target[. = 'test_share']/guest ok\" no",
            "rm  \"target[. = 'test_share']/guest only\"",
            "rm  \"target[. = 'test_share']/hide unreadable\"",
            "rm  target[. = 'test_share']/path",
            "rm  \"target[. = 'test_share']/read only\"",
            "rm  \"target[. = 'test_share']/public\"",
            "rm  \"target[. = 'test_share']/writable\"",
            "rm  \"target[. = 'test_share']/printable\"",
            "rm  \"target[. = 'test_share']/follow symlinks\"",
            "rm  \"target[. = 'test_share']/wide links\"",
            "rm  \"target[. = 'test_share']/map acl inherit\"",
            "rm  \"target[. = 'test_share']/store dos attributes\"",
            "rm  \"target[. = 'test_share']/strict allocate\"",
            "rm  \"target[. = 'test_share']/valid users\"",
            "rm  \"target[. = 'test_share']/oplocks\"",
            "rm  \"target[. = 'test_share']/level2 oplocks\"",
            "rm  \"target[. = 'test_share']/veto oplock files\"",
            "rm  \"target[. = 'test_share']/write list\"",
            "rm  \"target[. = 'test_share']/hide dot files\"",
            "rm  \"target[. = 'test_share']/root preexec\""
          ],
          :require => 'Augeas[test_share-section]',
          :notify  => 'Class[Samba::Server::Service]')
        }
      end#guest_ok false

      context 'when called with guest_only set to true' do
        let(:title) { 'test_share' }
        let(:params) {{
          :ensure     => 'present',
          :guest_only => true,
        }}
        it { is_expected.to contain_samba__server__share('test_share') }
        it { is_expected.to contain_augeas('test_share-section').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => ["set target[. = 'test_share'] 'test_share'"],
          :require => 'Class[Samba::Server::Config]',
          :notify  => 'Class[Samba::Server::Service]')
        }
        it { is_expected.to contain_augeas('test_share-changes').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => [
            "rm  \"target[. = 'test_share']/available\"",
            "rm  \"target[. = 'test_share']/browsable\"",
            "rm  \"target[. = 'test_share']/comment\"",
            "rm  \"target[. = 'test_share']/copy\"",
            "rm  \"target[. = 'test_share']/create mask\"",
            "rm  \"target[. = 'test_share']/directory mask\"",
            "rm  \"target[. = 'test_share']/force create mask\"",
            "rm  \"target[. = 'test_share']/force directory mode\"",
            "rm  \"target[. = 'test_share']/force group\"",
            "rm  \"target[. = 'test_share']/force user\"",
            "rm  \"target[. = 'test_share']/guest ok\"",
            "set \"target[. = 'test_share']/guest only\" yes",
            "rm  \"target[. = 'test_share']/hide unreadable\"",
            "rm  target[. = 'test_share']/path",
            "rm  \"target[. = 'test_share']/read only\"",
            "rm  \"target[. = 'test_share']/public\"",
            "rm  \"target[. = 'test_share']/writable\"",
            "rm  \"target[. = 'test_share']/printable\"",
            "rm  \"target[. = 'test_share']/follow symlinks\"",
            "rm  \"target[. = 'test_share']/wide links\"",
            "rm  \"target[. = 'test_share']/map acl inherit\"",
            "rm  \"target[. = 'test_share']/store dos attributes\"",
            "rm  \"target[. = 'test_share']/strict allocate\"",
            "rm  \"target[. = 'test_share']/valid users\"",
            "rm  \"target[. = 'test_share']/oplocks\"",
            "rm  \"target[. = 'test_share']/level2 oplocks\"",
            "rm  \"target[. = 'test_share']/veto oplock files\"",
            "rm  \"target[. = 'test_share']/write list\"",
            "rm  \"target[. = 'test_share']/hide dot files\"",
            "rm  \"target[. = 'test_share']/root preexec\""
          ],
          :require => 'Augeas[test_share-section]',
          :notify  => 'Class[Samba::Server::Service]')
        }
      end#guest_only false

      context 'when called with guest_only set to false' do
        let(:title) { 'test_share' }
        let(:params) {{
          :ensure     => 'present',
          :guest_only => false,
        }}
        it { is_expected.to contain_samba__server__share('test_share') }
        it { is_expected.to contain_augeas('test_share-section').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => ["set target[. = 'test_share'] 'test_share'"],
          :require => 'Class[Samba::Server::Config]',
          :notify  => 'Class[Samba::Server::Service]')
        }
        it { is_expected.to contain_augeas('test_share-changes').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => [
            "rm  \"target[. = 'test_share']/available\"",
            "rm  \"target[. = 'test_share']/browsable\"",
            "rm  \"target[. = 'test_share']/comment\"",
            "rm  \"target[. = 'test_share']/copy\"",
            "rm  \"target[. = 'test_share']/create mask\"",
            "rm  \"target[. = 'test_share']/directory mask\"",
            "rm  \"target[. = 'test_share']/force create mask\"",
            "rm  \"target[. = 'test_share']/force directory mode\"",
            "rm  \"target[. = 'test_share']/force group\"",
            "rm  \"target[. = 'test_share']/force user\"",
            "rm  \"target[. = 'test_share']/guest ok\"",
            "set \"target[. = 'test_share']/guest only\" no",
            "rm  \"target[. = 'test_share']/hide unreadable\"",
            "rm  target[. = 'test_share']/path",
            "rm  \"target[. = 'test_share']/read only\"",
            "rm  \"target[. = 'test_share']/public\"",
            "rm  \"target[. = 'test_share']/writable\"",
            "rm  \"target[. = 'test_share']/printable\"",
            "rm  \"target[. = 'test_share']/follow symlinks\"",
            "rm  \"target[. = 'test_share']/wide links\"",
            "rm  \"target[. = 'test_share']/map acl inherit\"",
            "rm  \"target[. = 'test_share']/store dos attributes\"",
            "rm  \"target[. = 'test_share']/strict allocate\"",
            "rm  \"target[. = 'test_share']/valid users\"",
            "rm  \"target[. = 'test_share']/oplocks\"",
            "rm  \"target[. = 'test_share']/level2 oplocks\"",
            "rm  \"target[. = 'test_share']/veto oplock files\"",
            "rm  \"target[. = 'test_share']/write list\"",
            "rm  \"target[. = 'test_share']/hide dot files\"",
            "rm  \"target[. = 'test_share']/root preexec\""
          ],
          :require => 'Augeas[test_share-section]',
          :notify  => 'Class[Samba::Server::Service]')
        }
      end#guest_only false

      context 'when called with hide_unreadable set to true' do
        let(:title) { 'test_share' }
        let(:params) {{
          :ensure          => 'present',
          :hide_unreadable => true,
        }}
        it { is_expected.to contain_samba__server__share('test_share') }
        it { is_expected.to contain_augeas('test_share-section').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => ["set target[. = 'test_share'] 'test_share'"],
          :require => 'Class[Samba::Server::Config]',
          :notify  => 'Class[Samba::Server::Service]')
        }
        it { is_expected.to contain_augeas('test_share-changes').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => [
            "rm  \"target[. = 'test_share']/available\"",
            "rm  \"target[. = 'test_share']/browsable\"",
            "rm  \"target[. = 'test_share']/comment\"",
            "rm  \"target[. = 'test_share']/copy\"",
            "rm  \"target[. = 'test_share']/create mask\"",
            "rm  \"target[. = 'test_share']/directory mask\"",
            "rm  \"target[. = 'test_share']/force create mask\"",
            "rm  \"target[. = 'test_share']/force directory mode\"",
            "rm  \"target[. = 'test_share']/force group\"",
            "rm  \"target[. = 'test_share']/force user\"",
            "rm  \"target[. = 'test_share']/guest ok\"",
            "rm  \"target[. = 'test_share']/guest only\"",
            "set \"target[. = 'test_share']/hide unreadable\" yes",
            "rm  target[. = 'test_share']/path",
            "rm  \"target[. = 'test_share']/read only\"",
            "rm  \"target[. = 'test_share']/public\"",
            "rm  \"target[. = 'test_share']/writable\"",
            "rm  \"target[. = 'test_share']/printable\"",
            "rm  \"target[. = 'test_share']/follow symlinks\"",
            "rm  \"target[. = 'test_share']/wide links\"",
            "rm  \"target[. = 'test_share']/map acl inherit\"",
            "rm  \"target[. = 'test_share']/store dos attributes\"",
            "rm  \"target[. = 'test_share']/strict allocate\"",
            "rm  \"target[. = 'test_share']/valid users\"",
            "rm  \"target[. = 'test_share']/oplocks\"",
            "rm  \"target[. = 'test_share']/level2 oplocks\"",
            "rm  \"target[. = 'test_share']/veto oplock files\"",
            "rm  \"target[. = 'test_share']/write list\"",
            "rm  \"target[. = 'test_share']/hide dot files\"",
            "rm  \"target[. = 'test_share']/root preexec\""
          ],
          :require => 'Augeas[test_share-section]',
          :notify  => 'Class[Samba::Server::Service]')
        }
      end#hide_unreadable true

      context 'when called with hide_unreadable set to false' do
        let(:title) { 'test_share' }
        let(:params) {{
          :ensure          => 'present',
          :hide_unreadable => false,
        }}
        it { is_expected.to contain_samba__server__share('test_share') }
        it { is_expected.to contain_augeas('test_share-section').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => ["set target[. = 'test_share'] 'test_share'"],
          :require => 'Class[Samba::Server::Config]',
          :notify  => 'Class[Samba::Server::Service]')
        }
        it { is_expected.to contain_augeas('test_share-changes').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => [
            "rm  \"target[. = 'test_share']/available\"",
            "rm  \"target[. = 'test_share']/browsable\"",
            "rm  \"target[. = 'test_share']/comment\"",
            "rm  \"target[. = 'test_share']/copy\"",
            "rm  \"target[. = 'test_share']/create mask\"",
            "rm  \"target[. = 'test_share']/directory mask\"",
            "rm  \"target[. = 'test_share']/force create mask\"",
            "rm  \"target[. = 'test_share']/force directory mode\"",
            "rm  \"target[. = 'test_share']/force group\"",
            "rm  \"target[. = 'test_share']/force user\"",
            "rm  \"target[. = 'test_share']/guest ok\"",
            "rm  \"target[. = 'test_share']/guest only\"",
            "set \"target[. = 'test_share']/hide unreadable\" no",
            "rm  target[. = 'test_share']/path",
            "rm  \"target[. = 'test_share']/read only\"",
            "rm  \"target[. = 'test_share']/public\"",
            "rm  \"target[. = 'test_share']/writable\"",
            "rm  \"target[. = 'test_share']/printable\"",
            "rm  \"target[. = 'test_share']/follow symlinks\"",
            "rm  \"target[. = 'test_share']/wide links\"",
            "rm  \"target[. = 'test_share']/map acl inherit\"",
            "rm  \"target[. = 'test_share']/store dos attributes\"",
            "rm  \"target[. = 'test_share']/strict allocate\"",
            "rm  \"target[. = 'test_share']/valid users\"",
            "rm  \"target[. = 'test_share']/oplocks\"",
            "rm  \"target[. = 'test_share']/level2 oplocks\"",
            "rm  \"target[. = 'test_share']/veto oplock files\"",
            "rm  \"target[. = 'test_share']/write list\"",
            "rm  \"target[. = 'test_share']/hide dot files\"",
            "rm  \"target[. = 'test_share']/root preexec\""
          ],
          :require => 'Augeas[test_share-section]',
          :notify  => 'Class[Samba::Server::Service]')
        }
      end#hide_unreadable false

      context 'when called with path set to /tmp' do
        let(:title) { 'test_share' }
        let(:params) {{
          :ensure => 'present',
          :path   => '/tmp',
        }}
        it { is_expected.to contain_samba__server__share('test_share') }
        it { is_expected.to contain_augeas('test_share-section').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => ["set target[. = 'test_share'] 'test_share'"],
          :require => 'Class[Samba::Server::Config]',
          :notify  => 'Class[Samba::Server::Service]')
        }
        it { is_expected.to contain_augeas('test_share-changes').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => [
            "rm  \"target[. = 'test_share']/available\"",
            "rm  \"target[. = 'test_share']/browsable\"",
            "rm  \"target[. = 'test_share']/comment\"",
            "rm  \"target[. = 'test_share']/copy\"",
            "rm  \"target[. = 'test_share']/create mask\"",
            "rm  \"target[. = 'test_share']/directory mask\"",
            "rm  \"target[. = 'test_share']/force create mask\"",
            "rm  \"target[. = 'test_share']/force directory mode\"",
            "rm  \"target[. = 'test_share']/force group\"",
            "rm  \"target[. = 'test_share']/force user\"",
            "rm  \"target[. = 'test_share']/guest ok\"",
            "rm  \"target[. = 'test_share']/guest only\"",
            "rm  \"target[. = 'test_share']/hide unreadable\"",
            "set target[. = 'test_share']/path '/tmp'",
            "rm  \"target[. = 'test_share']/read only\"",
            "rm  \"target[. = 'test_share']/public\"",
            "rm  \"target[. = 'test_share']/writable\"",
            "rm  \"target[. = 'test_share']/printable\"",
            "rm  \"target[. = 'test_share']/follow symlinks\"",
            "rm  \"target[. = 'test_share']/wide links\"",
            "rm  \"target[. = 'test_share']/map acl inherit\"",
            "rm  \"target[. = 'test_share']/store dos attributes\"",
            "rm  \"target[. = 'test_share']/strict allocate\"",
            "rm  \"target[. = 'test_share']/valid users\"",
            "rm  \"target[. = 'test_share']/oplocks\"",
            "rm  \"target[. = 'test_share']/level2 oplocks\"",
            "rm  \"target[. = 'test_share']/veto oplock files\"",
            "rm  \"target[. = 'test_share']/write list\"",
            "rm  \"target[. = 'test_share']/hide dot files\"",
            "rm  \"target[. = 'test_share']/root preexec\""
          ],
          :require => 'Augeas[test_share-section]',
          :notify  => 'Class[Samba::Server::Service]')
        }
      end#path

      context 'when called with read_only set to true' do
        let(:title) { 'test_share' }
        let(:params) {{
          :ensure    => 'present',
          :read_only => true,
        }}
        it { is_expected.to contain_samba__server__share('test_share') }
        it { is_expected.to contain_augeas('test_share-section').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => ["set target[. = 'test_share'] 'test_share'"],
          :require => 'Class[Samba::Server::Config]',
          :notify  => 'Class[Samba::Server::Service]')
        }
        it { is_expected.to contain_augeas('test_share-changes').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => [
            "rm  \"target[. = 'test_share']/available\"",
            "rm  \"target[. = 'test_share']/browsable\"",
            "rm  \"target[. = 'test_share']/comment\"",
            "rm  \"target[. = 'test_share']/copy\"",
            "rm  \"target[. = 'test_share']/create mask\"",
            "rm  \"target[. = 'test_share']/directory mask\"",
            "rm  \"target[. = 'test_share']/force create mask\"",
            "rm  \"target[. = 'test_share']/force directory mode\"",
            "rm  \"target[. = 'test_share']/force group\"",
            "rm  \"target[. = 'test_share']/force user\"",
            "rm  \"target[. = 'test_share']/guest ok\"",
            "rm  \"target[. = 'test_share']/guest only\"",
            "rm  \"target[. = 'test_share']/hide unreadable\"",
            "rm  target[. = 'test_share']/path",
            "set \"target[. = 'test_share']/read only\" yes",
            "rm  \"target[. = 'test_share']/public\"",
            "rm  \"target[. = 'test_share']/writable\"",
            "rm  \"target[. = 'test_share']/printable\"",
            "rm  \"target[. = 'test_share']/follow symlinks\"",
            "rm  \"target[. = 'test_share']/wide links\"",
            "rm  \"target[. = 'test_share']/map acl inherit\"",
            "rm  \"target[. = 'test_share']/store dos attributes\"",
            "rm  \"target[. = 'test_share']/strict allocate\"",
            "rm  \"target[. = 'test_share']/valid users\"",
            "rm  \"target[. = 'test_share']/oplocks\"",
            "rm  \"target[. = 'test_share']/level2 oplocks\"",
            "rm  \"target[. = 'test_share']/veto oplock files\"",
            "rm  \"target[. = 'test_share']/write list\"",
            "rm  \"target[. = 'test_share']/hide dot files\"",
            "rm  \"target[. = 'test_share']/root preexec\""
          ],
          :require => 'Augeas[test_share-section]',
          :notify  => 'Class[Samba::Server::Service]')
        }
      end#read_only true

      context 'when called with read_only set to false' do
        let(:title) { 'test_share' }
        let(:params) {{
          :ensure    => 'present',
          :read_only => false,
        }}
        it { is_expected.to contain_samba__server__share('test_share') }
        it { is_expected.to contain_augeas('test_share-section').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => ["set target[. = 'test_share'] 'test_share'"],
          :require => 'Class[Samba::Server::Config]',
          :notify  => 'Class[Samba::Server::Service]')
        }
        it { is_expected.to contain_augeas('test_share-changes').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => [
            "rm  \"target[. = 'test_share']/available\"",
            "rm  \"target[. = 'test_share']/browsable\"",
            "rm  \"target[. = 'test_share']/comment\"",
            "rm  \"target[. = 'test_share']/copy\"",
            "rm  \"target[. = 'test_share']/create mask\"",
            "rm  \"target[. = 'test_share']/directory mask\"",
            "rm  \"target[. = 'test_share']/force create mask\"",
            "rm  \"target[. = 'test_share']/force directory mode\"",
            "rm  \"target[. = 'test_share']/force group\"",
            "rm  \"target[. = 'test_share']/force user\"",
            "rm  \"target[. = 'test_share']/guest ok\"",
            "rm  \"target[. = 'test_share']/guest only\"",
            "rm  \"target[. = 'test_share']/hide unreadable\"",
            "rm  target[. = 'test_share']/path",
            "set \"target[. = 'test_share']/read only\" no",
            "rm  \"target[. = 'test_share']/public\"",
            "rm  \"target[. = 'test_share']/writable\"",
            "rm  \"target[. = 'test_share']/printable\"",
            "rm  \"target[. = 'test_share']/follow symlinks\"",
            "rm  \"target[. = 'test_share']/wide links\"",
            "rm  \"target[. = 'test_share']/map acl inherit\"",
            "rm  \"target[. = 'test_share']/store dos attributes\"",
            "rm  \"target[. = 'test_share']/strict allocate\"",
            "rm  \"target[. = 'test_share']/valid users\"",
            "rm  \"target[. = 'test_share']/oplocks\"",
            "rm  \"target[. = 'test_share']/level2 oplocks\"",
            "rm  \"target[. = 'test_share']/veto oplock files\"",
            "rm  \"target[. = 'test_share']/write list\"",
            "rm  \"target[. = 'test_share']/hide dot files\"",
            "rm  \"target[. = 'test_share']/root preexec\""
          ],
          :require => 'Augeas[test_share-section]',
          :notify  => 'Class[Samba::Server::Service]')
        }
      end#read_only false

      context 'when called with public set to true' do
        let(:title) { 'test_share' }
        let(:params) {{
          :ensure => 'present',
          :public => true,
        }}
        it { is_expected.to contain_samba__server__share('test_share') }
        it { is_expected.to contain_augeas('test_share-section').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => ["set target[. = 'test_share'] 'test_share'"],
          :require => 'Class[Samba::Server::Config]',
          :notify  => 'Class[Samba::Server::Service]')
        }
        it { is_expected.to contain_augeas('test_share-changes').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => [
            "rm  \"target[. = 'test_share']/available\"",
            "rm  \"target[. = 'test_share']/browsable\"",
            "rm  \"target[. = 'test_share']/comment\"",
            "rm  \"target[. = 'test_share']/copy\"",
            "rm  \"target[. = 'test_share']/create mask\"",
            "rm  \"target[. = 'test_share']/directory mask\"",
            "rm  \"target[. = 'test_share']/force create mask\"",
            "rm  \"target[. = 'test_share']/force directory mode\"",
            "rm  \"target[. = 'test_share']/force group\"",
            "rm  \"target[. = 'test_share']/force user\"",
            "rm  \"target[. = 'test_share']/guest ok\"",
            "rm  \"target[. = 'test_share']/guest only\"",
            "rm  \"target[. = 'test_share']/hide unreadable\"",
            "rm  target[. = 'test_share']/path",
            "rm  \"target[. = 'test_share']/read only\"",
            "set \"target[. = 'test_share']/public\" yes",
            "rm  \"target[. = 'test_share']/writable\"",
            "rm  \"target[. = 'test_share']/printable\"",
            "rm  \"target[. = 'test_share']/follow symlinks\"",
            "rm  \"target[. = 'test_share']/wide links\"",
            "rm  \"target[. = 'test_share']/map acl inherit\"",
            "rm  \"target[. = 'test_share']/store dos attributes\"",
            "rm  \"target[. = 'test_share']/strict allocate\"",
            "rm  \"target[. = 'test_share']/valid users\"",
            "rm  \"target[. = 'test_share']/oplocks\"",
            "rm  \"target[. = 'test_share']/level2 oplocks\"",
            "rm  \"target[. = 'test_share']/veto oplock files\"",
            "rm  \"target[. = 'test_share']/write list\"",
            "rm  \"target[. = 'test_share']/hide dot files\"",
            "rm  \"target[. = 'test_share']/root preexec\""
          ],
          :require => 'Augeas[test_share-section]',
          :notify  => 'Class[Samba::Server::Service]')
        }
      end#public true

      context 'when called with public set to false' do
        let(:title) { 'test_share' }
        let(:params) {{
          :ensure => 'present',
          :public => false,
        }}
        it { is_expected.to contain_samba__server__share('test_share') }
        it { is_expected.to contain_augeas('test_share-section').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => ["set target[. = 'test_share'] 'test_share'"],
          :require => 'Class[Samba::Server::Config]',
          :notify  => 'Class[Samba::Server::Service]')
        }
        it { is_expected.to contain_augeas('test_share-changes').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => [
            "rm  \"target[. = 'test_share']/available\"",
            "rm  \"target[. = 'test_share']/browsable\"",
            "rm  \"target[. = 'test_share']/comment\"",
            "rm  \"target[. = 'test_share']/copy\"",
            "rm  \"target[. = 'test_share']/create mask\"",
            "rm  \"target[. = 'test_share']/directory mask\"",
            "rm  \"target[. = 'test_share']/force create mask\"",
            "rm  \"target[. = 'test_share']/force directory mode\"",
            "rm  \"target[. = 'test_share']/force group\"",
            "rm  \"target[. = 'test_share']/force user\"",
            "rm  \"target[. = 'test_share']/guest ok\"",
            "rm  \"target[. = 'test_share']/guest only\"",
            "rm  \"target[. = 'test_share']/hide unreadable\"",
            "rm  target[. = 'test_share']/path",
            "rm  \"target[. = 'test_share']/read only\"",
            "set \"target[. = 'test_share']/public\" no",
            "rm  \"target[. = 'test_share']/writable\"",
            "rm  \"target[. = 'test_share']/printable\"",
            "rm  \"target[. = 'test_share']/follow symlinks\"",
            "rm  \"target[. = 'test_share']/wide links\"",
            "rm  \"target[. = 'test_share']/map acl inherit\"",
            "rm  \"target[. = 'test_share']/store dos attributes\"",
            "rm  \"target[. = 'test_share']/strict allocate\"",
            "rm  \"target[. = 'test_share']/valid users\"",
            "rm  \"target[. = 'test_share']/oplocks\"",
            "rm  \"target[. = 'test_share']/level2 oplocks\"",
            "rm  \"target[. = 'test_share']/veto oplock files\"",
            "rm  \"target[. = 'test_share']/write list\"",
            "rm  \"target[. = 'test_share']/hide dot files\"",
            "rm  \"target[. = 'test_share']/root preexec\""
          ],
          :require => 'Augeas[test_share-section]',
          :notify  => 'Class[Samba::Server::Service]')
        }
      end#public false

      context 'when called with writable set to true' do
        let(:title) { 'test_share' }
        let(:params) {{
          :ensure   => 'present',
          :writable => true,
        }}
        it { is_expected.to contain_samba__server__share('test_share') }
        it { is_expected.to contain_augeas('test_share-section').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => ["set target[. = 'test_share'] 'test_share'"],
          :require => 'Class[Samba::Server::Config]',
          :notify  => 'Class[Samba::Server::Service]')
        }
        it { is_expected.to contain_augeas('test_share-changes').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => [
            "rm  \"target[. = 'test_share']/available\"",
            "rm  \"target[. = 'test_share']/browsable\"",
            "rm  \"target[. = 'test_share']/comment\"",
            "rm  \"target[. = 'test_share']/copy\"",
            "rm  \"target[. = 'test_share']/create mask\"",
            "rm  \"target[. = 'test_share']/directory mask\"",
            "rm  \"target[. = 'test_share']/force create mask\"",
            "rm  \"target[. = 'test_share']/force directory mode\"",
            "rm  \"target[. = 'test_share']/force group\"",
            "rm  \"target[. = 'test_share']/force user\"",
            "rm  \"target[. = 'test_share']/guest ok\"",
            "rm  \"target[. = 'test_share']/guest only\"",
            "rm  \"target[. = 'test_share']/hide unreadable\"",
            "rm  target[. = 'test_share']/path",
            "rm  \"target[. = 'test_share']/read only\"",
            "rm  \"target[. = 'test_share']/public\"",
            "set \"target[. = 'test_share']/writable\" yes",
            "rm  \"target[. = 'test_share']/printable\"",
            "rm  \"target[. = 'test_share']/follow symlinks\"",
            "rm  \"target[. = 'test_share']/wide links\"",
            "rm  \"target[. = 'test_share']/map acl inherit\"",
            "rm  \"target[. = 'test_share']/store dos attributes\"",
            "rm  \"target[. = 'test_share']/strict allocate\"",
            "rm  \"target[. = 'test_share']/valid users\"",
            "rm  \"target[. = 'test_share']/oplocks\"",
            "rm  \"target[. = 'test_share']/level2 oplocks\"",
            "rm  \"target[. = 'test_share']/veto oplock files\"",
            "rm  \"target[. = 'test_share']/write list\"",
            "rm  \"target[. = 'test_share']/hide dot files\"",
            "rm  \"target[. = 'test_share']/root preexec\""
          ],
          :require => 'Augeas[test_share-section]',
          :notify  => 'Class[Samba::Server::Service]')
        }
      end#writable true

      context 'when called with writable set to false' do
        let(:title) { 'test_share' }
        let(:params) {{
          :ensure   => 'present',
          :writable => false,
        }}
        it { is_expected.to contain_samba__server__share('test_share') }
        it { is_expected.to contain_augeas('test_share-section').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => ["set target[. = 'test_share'] 'test_share'"],
          :require => 'Class[Samba::Server::Config]',
          :notify  => 'Class[Samba::Server::Service]')
        }
        it { is_expected.to contain_augeas('test_share-changes').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => [
            "rm  \"target[. = 'test_share']/available\"",
            "rm  \"target[. = 'test_share']/browsable\"",
            "rm  \"target[. = 'test_share']/comment\"",
            "rm  \"target[. = 'test_share']/copy\"",
            "rm  \"target[. = 'test_share']/create mask\"",
            "rm  \"target[. = 'test_share']/directory mask\"",
            "rm  \"target[. = 'test_share']/force create mask\"",
            "rm  \"target[. = 'test_share']/force directory mode\"",
            "rm  \"target[. = 'test_share']/force group\"",
            "rm  \"target[. = 'test_share']/force user\"",
            "rm  \"target[. = 'test_share']/guest ok\"",
            "rm  \"target[. = 'test_share']/guest only\"",
            "rm  \"target[. = 'test_share']/hide unreadable\"",
            "rm  target[. = 'test_share']/path",
            "rm  \"target[. = 'test_share']/read only\"",
            "rm  \"target[. = 'test_share']/public\"",
            "set \"target[. = 'test_share']/writable\" no",
            "rm  \"target[. = 'test_share']/printable\"",
            "rm  \"target[. = 'test_share']/follow symlinks\"",
            "rm  \"target[. = 'test_share']/wide links\"",
            "rm  \"target[. = 'test_share']/map acl inherit\"",
            "rm  \"target[. = 'test_share']/store dos attributes\"",
            "rm  \"target[. = 'test_share']/strict allocate\"",
            "rm  \"target[. = 'test_share']/valid users\"",
            "rm  \"target[. = 'test_share']/oplocks\"",
            "rm  \"target[. = 'test_share']/level2 oplocks\"",
            "rm  \"target[. = 'test_share']/veto oplock files\"",
            "rm  \"target[. = 'test_share']/write list\"",
            "rm  \"target[. = 'test_share']/hide dot files\"",
            "rm  \"target[. = 'test_share']/root preexec\""
          ],
          :require => 'Augeas[test_share-section]',
          :notify  => 'Class[Samba::Server::Service]')
        }
      end#writable false

      context 'when called with printable set to true' do
        let(:title) { 'test_share' }
        let(:params) {{
          :ensure    => 'present',
          :printable => true,
        }}
        it { is_expected.to contain_samba__server__share('test_share') }
        it { is_expected.to contain_augeas('test_share-section').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => ["set target[. = 'test_share'] 'test_share'"],
          :require => 'Class[Samba::Server::Config]',
          :notify  => 'Class[Samba::Server::Service]')
        }
        it { is_expected.to contain_augeas('test_share-changes').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => [
            "rm  \"target[. = 'test_share']/available\"",
            "rm  \"target[. = 'test_share']/browsable\"",
            "rm  \"target[. = 'test_share']/comment\"",
            "rm  \"target[. = 'test_share']/copy\"",
            "rm  \"target[. = 'test_share']/create mask\"",
            "rm  \"target[. = 'test_share']/directory mask\"",
            "rm  \"target[. = 'test_share']/force create mask\"",
            "rm  \"target[. = 'test_share']/force directory mode\"",
            "rm  \"target[. = 'test_share']/force group\"",
            "rm  \"target[. = 'test_share']/force user\"",
            "rm  \"target[. = 'test_share']/guest ok\"",
            "rm  \"target[. = 'test_share']/guest only\"",
            "rm  \"target[. = 'test_share']/hide unreadable\"",
            "rm  target[. = 'test_share']/path",
            "rm  \"target[. = 'test_share']/read only\"",
            "rm  \"target[. = 'test_share']/public\"",
            "rm  \"target[. = 'test_share']/writable\"",
            "set \"target[. = 'test_share']/printable\" yes",
            "rm  \"target[. = 'test_share']/follow symlinks\"",
            "rm  \"target[. = 'test_share']/wide links\"",
            "rm  \"target[. = 'test_share']/map acl inherit\"",
            "rm  \"target[. = 'test_share']/store dos attributes\"",
            "rm  \"target[. = 'test_share']/strict allocate\"",
            "rm  \"target[. = 'test_share']/valid users\"",
            "rm  \"target[. = 'test_share']/oplocks\"",
            "rm  \"target[. = 'test_share']/level2 oplocks\"",
            "rm  \"target[. = 'test_share']/veto oplock files\"",
            "rm  \"target[. = 'test_share']/write list\"",
            "rm  \"target[. = 'test_share']/hide dot files\"",
            "rm  \"target[. = 'test_share']/root preexec\""
          ],
          :require => 'Augeas[test_share-section]',
          :notify  => 'Class[Samba::Server::Service]')
        }
      end#printable true

      context 'when called with printable set to false' do
        let(:title) { 'test_share' }
        let(:params) {{
          :ensure    => 'present',
          :printable => false,
        }}
        it { is_expected.to contain_samba__server__share('test_share') }
        it { is_expected.to contain_augeas('test_share-section').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => ["set target[. = 'test_share'] 'test_share'"],
          :require => 'Class[Samba::Server::Config]',
          :notify  => 'Class[Samba::Server::Service]')
        }
        it { is_expected.to contain_augeas('test_share-changes').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => [
            "rm  \"target[. = 'test_share']/available\"",
            "rm  \"target[. = 'test_share']/browsable\"",
            "rm  \"target[. = 'test_share']/comment\"",
            "rm  \"target[. = 'test_share']/copy\"",
            "rm  \"target[. = 'test_share']/create mask\"",
            "rm  \"target[. = 'test_share']/directory mask\"",
            "rm  \"target[. = 'test_share']/force create mask\"",
            "rm  \"target[. = 'test_share']/force directory mode\"",
            "rm  \"target[. = 'test_share']/force group\"",
            "rm  \"target[. = 'test_share']/force user\"",
            "rm  \"target[. = 'test_share']/guest ok\"",
            "rm  \"target[. = 'test_share']/guest only\"",
            "rm  \"target[. = 'test_share']/hide unreadable\"",
            "rm  target[. = 'test_share']/path",
            "rm  \"target[. = 'test_share']/read only\"",
            "rm  \"target[. = 'test_share']/public\"",
            "rm  \"target[. = 'test_share']/writable\"",
            "set \"target[. = 'test_share']/printable\" no",
            "rm  \"target[. = 'test_share']/follow symlinks\"",
            "rm  \"target[. = 'test_share']/wide links\"",
            "rm  \"target[. = 'test_share']/map acl inherit\"",
            "rm  \"target[. = 'test_share']/store dos attributes\"",
            "rm  \"target[. = 'test_share']/strict allocate\"",
            "rm  \"target[. = 'test_share']/valid users\"",
            "rm  \"target[. = 'test_share']/oplocks\"",
            "rm  \"target[. = 'test_share']/level2 oplocks\"",
            "rm  \"target[. = 'test_share']/veto oplock files\"",
            "rm  \"target[. = 'test_share']/write list\"",
            "rm  \"target[. = 'test_share']/hide dot files\"",
            "rm  \"target[. = 'test_share']/root preexec\""
          ],
          :require => 'Augeas[test_share-section]',
          :notify  => 'Class[Samba::Server::Service]')
        }
      end#printable false

      context 'when called with follow_symlinks set to true' do
        let(:title) { 'test_share' }
        let(:params) {{
          :ensure          => 'present',
          :follow_symlinks => true,
        }}
        it { is_expected.to contain_samba__server__share('test_share') }
        it { is_expected.to contain_augeas('test_share-section').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => ["set target[. = 'test_share'] 'test_share'"],
          :require => 'Class[Samba::Server::Config]',
          :notify  => 'Class[Samba::Server::Service]')
        }
        it { is_expected.to contain_augeas('test_share-changes').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => [
            "rm  \"target[. = 'test_share']/available\"",
            "rm  \"target[. = 'test_share']/browsable\"",
            "rm  \"target[. = 'test_share']/comment\"",
            "rm  \"target[. = 'test_share']/copy\"",
            "rm  \"target[. = 'test_share']/create mask\"",
            "rm  \"target[. = 'test_share']/directory mask\"",
            "rm  \"target[. = 'test_share']/force create mask\"",
            "rm  \"target[. = 'test_share']/force directory mode\"",
            "rm  \"target[. = 'test_share']/force group\"",
            "rm  \"target[. = 'test_share']/force user\"",
            "rm  \"target[. = 'test_share']/guest ok\"",
            "rm  \"target[. = 'test_share']/guest only\"",
            "rm  \"target[. = 'test_share']/hide unreadable\"",
            "rm  target[. = 'test_share']/path",
            "rm  \"target[. = 'test_share']/read only\"",
            "rm  \"target[. = 'test_share']/public\"",
            "rm  \"target[. = 'test_share']/writable\"",
            "rm  \"target[. = 'test_share']/printable\"",
            "set \"target[. = 'test_share']/follow symlinks\" yes",
            "rm  \"target[. = 'test_share']/wide links\"",
            "rm  \"target[. = 'test_share']/map acl inherit\"",
            "rm  \"target[. = 'test_share']/store dos attributes\"",
            "rm  \"target[. = 'test_share']/strict allocate\"",
            "rm  \"target[. = 'test_share']/valid users\"",
            "rm  \"target[. = 'test_share']/oplocks\"",
            "rm  \"target[. = 'test_share']/level2 oplocks\"",
            "rm  \"target[. = 'test_share']/veto oplock files\"",
            "rm  \"target[. = 'test_share']/write list\"",
            "rm  \"target[. = 'test_share']/hide dot files\"",
            "rm  \"target[. = 'test_share']/root preexec\""
          ],
          :require => 'Augeas[test_share-section]',
          :notify  => 'Class[Samba::Server::Service]')
        }
      end#follow_symlinks true

      context 'when called with follow_symlinks set to false' do
        let(:title) { 'test_share' }
        let(:params) {{
          :ensure          => 'present',
          :follow_symlinks => false,
        }}
        it { is_expected.to contain_samba__server__share('test_share') }
        it { is_expected.to contain_augeas('test_share-section').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => ["set target[. = 'test_share'] 'test_share'"],
          :require => 'Class[Samba::Server::Config]',
          :notify  => 'Class[Samba::Server::Service]')
        }
        it { is_expected.to contain_augeas('test_share-changes').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => [
            "rm  \"target[. = 'test_share']/available\"",
            "rm  \"target[. = 'test_share']/browsable\"",
            "rm  \"target[. = 'test_share']/comment\"",
            "rm  \"target[. = 'test_share']/copy\"",
            "rm  \"target[. = 'test_share']/create mask\"",
            "rm  \"target[. = 'test_share']/directory mask\"",
            "rm  \"target[. = 'test_share']/force create mask\"",
            "rm  \"target[. = 'test_share']/force directory mode\"",
            "rm  \"target[. = 'test_share']/force group\"",
            "rm  \"target[. = 'test_share']/force user\"",
            "rm  \"target[. = 'test_share']/guest ok\"",
            "rm  \"target[. = 'test_share']/guest only\"",
            "rm  \"target[. = 'test_share']/hide unreadable\"",
            "rm  target[. = 'test_share']/path",
            "rm  \"target[. = 'test_share']/read only\"",
            "rm  \"target[. = 'test_share']/public\"",
            "rm  \"target[. = 'test_share']/writable\"",
            "rm  \"target[. = 'test_share']/printable\"",
            "set \"target[. = 'test_share']/follow symlinks\" no",
            "rm  \"target[. = 'test_share']/wide links\"",
            "rm  \"target[. = 'test_share']/map acl inherit\"",
            "rm  \"target[. = 'test_share']/store dos attributes\"",
            "rm  \"target[. = 'test_share']/strict allocate\"",
            "rm  \"target[. = 'test_share']/valid users\"",
            "rm  \"target[. = 'test_share']/oplocks\"",
            "rm  \"target[. = 'test_share']/level2 oplocks\"",
            "rm  \"target[. = 'test_share']/veto oplock files\"",
            "rm  \"target[. = 'test_share']/write list\"",
            "rm  \"target[. = 'test_share']/hide dot files\"",
            "rm  \"target[. = 'test_share']/root preexec\""
          ],
          :require => 'Augeas[test_share-section]',
          :notify  => 'Class[Samba::Server::Service]')
        }
      end#follow_symlinks false

      context 'when called with wide_links set to true' do
        let(:title) { 'test_share' }
        let(:params) {{
          :ensure     => 'present',
          :wide_links => true,
        }}
        it { is_expected.to contain_samba__server__share('test_share') }
        it { is_expected.to contain_augeas('test_share-section').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => ["set target[. = 'test_share'] 'test_share'"],
          :require => 'Class[Samba::Server::Config]',
          :notify  => 'Class[Samba::Server::Service]')
        }
        it { is_expected.to contain_augeas('test_share-changes').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => [
            "rm  \"target[. = 'test_share']/available\"",
            "rm  \"target[. = 'test_share']/browsable\"",
            "rm  \"target[. = 'test_share']/comment\"",
            "rm  \"target[. = 'test_share']/copy\"",
            "rm  \"target[. = 'test_share']/create mask\"",
            "rm  \"target[. = 'test_share']/directory mask\"",
            "rm  \"target[. = 'test_share']/force create mask\"",
            "rm  \"target[. = 'test_share']/force directory mode\"",
            "rm  \"target[. = 'test_share']/force group\"",
            "rm  \"target[. = 'test_share']/force user\"",
            "rm  \"target[. = 'test_share']/guest ok\"",
            "rm  \"target[. = 'test_share']/guest only\"",
            "rm  \"target[. = 'test_share']/hide unreadable\"",
            "rm  target[. = 'test_share']/path",
            "rm  \"target[. = 'test_share']/read only\"",
            "rm  \"target[. = 'test_share']/public\"",
            "rm  \"target[. = 'test_share']/writable\"",
            "rm  \"target[. = 'test_share']/printable\"",
            "rm  \"target[. = 'test_share']/follow symlinks\"",
            "set \"target[. = 'test_share']/wide links\" yes",
            "rm  \"target[. = 'test_share']/map acl inherit\"",
            "rm  \"target[. = 'test_share']/store dos attributes\"",
            "rm  \"target[. = 'test_share']/strict allocate\"",
            "rm  \"target[. = 'test_share']/valid users\"",
            "rm  \"target[. = 'test_share']/oplocks\"",
            "rm  \"target[. = 'test_share']/level2 oplocks\"",
            "rm  \"target[. = 'test_share']/veto oplock files\"",
            "rm  \"target[. = 'test_share']/write list\"",
            "rm  \"target[. = 'test_share']/hide dot files\"",
            "rm  \"target[. = 'test_share']/root preexec\""
          ],
          :require => 'Augeas[test_share-section]',
          :notify  => 'Class[Samba::Server::Service]')
        }
      end#wide_links true

      context 'when called with wide_links set to false' do
        let(:title) { 'test_share' }
        let(:params) {{
          :ensure     => 'present',
          :wide_links => false,
        }}
        it { is_expected.to contain_samba__server__share('test_share') }
        it { is_expected.to contain_augeas('test_share-section').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => ["set target[. = 'test_share'] 'test_share'"],
          :require => 'Class[Samba::Server::Config]',
          :notify  => 'Class[Samba::Server::Service]')
        }
        it { is_expected.to contain_augeas('test_share-changes').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => [
            "rm  \"target[. = 'test_share']/available\"",
            "rm  \"target[. = 'test_share']/browsable\"",
            "rm  \"target[. = 'test_share']/comment\"",
            "rm  \"target[. = 'test_share']/copy\"",
            "rm  \"target[. = 'test_share']/create mask\"",
            "rm  \"target[. = 'test_share']/directory mask\"",
            "rm  \"target[. = 'test_share']/force create mask\"",
            "rm  \"target[. = 'test_share']/force directory mode\"",
            "rm  \"target[. = 'test_share']/force group\"",
            "rm  \"target[. = 'test_share']/force user\"",
            "rm  \"target[. = 'test_share']/guest ok\"",
            "rm  \"target[. = 'test_share']/guest only\"",
            "rm  \"target[. = 'test_share']/hide unreadable\"",
            "rm  target[. = 'test_share']/path",
            "rm  \"target[. = 'test_share']/read only\"",
            "rm  \"target[. = 'test_share']/public\"",
            "rm  \"target[. = 'test_share']/writable\"",
            "rm  \"target[. = 'test_share']/printable\"",
            "rm  \"target[. = 'test_share']/follow symlinks\"",
            "set \"target[. = 'test_share']/wide links\" no",
            "rm  \"target[. = 'test_share']/map acl inherit\"",
            "rm  \"target[. = 'test_share']/store dos attributes\"",
            "rm  \"target[. = 'test_share']/strict allocate\"",
            "rm  \"target[. = 'test_share']/valid users\"",
            "rm  \"target[. = 'test_share']/oplocks\"",
            "rm  \"target[. = 'test_share']/level2 oplocks\"",
            "rm  \"target[. = 'test_share']/veto oplock files\"",
            "rm  \"target[. = 'test_share']/write list\"",
            "rm  \"target[. = 'test_share']/hide dot files\"",
            "rm  \"target[. = 'test_share']/root preexec\""
          ],
          :require => 'Augeas[test_share-section]',
          :notify  => 'Class[Samba::Server::Service]')
        }
      end#wide_links false

      context 'when called with map_acl_inherit set to true' do
        let(:title) { 'test_share' }
        let(:params) {{
          :ensure          => 'present',
          :map_acl_inherit => true,
        }}
        it { is_expected.to contain_samba__server__share('test_share') }
        it { is_expected.to contain_augeas('test_share-section').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => ["set target[. = 'test_share'] 'test_share'"],
          :require => 'Class[Samba::Server::Config]',
          :notify  => 'Class[Samba::Server::Service]')
        }
        it { is_expected.to contain_augeas('test_share-changes').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => [
            "rm  \"target[. = 'test_share']/available\"",
            "rm  \"target[. = 'test_share']/browsable\"",
            "rm  \"target[. = 'test_share']/comment\"",
            "rm  \"target[. = 'test_share']/copy\"",
            "rm  \"target[. = 'test_share']/create mask\"",
            "rm  \"target[. = 'test_share']/directory mask\"",
            "rm  \"target[. = 'test_share']/force create mask\"",
            "rm  \"target[. = 'test_share']/force directory mode\"",
            "rm  \"target[. = 'test_share']/force group\"",
            "rm  \"target[. = 'test_share']/force user\"",
            "rm  \"target[. = 'test_share']/guest ok\"",
            "rm  \"target[. = 'test_share']/guest only\"",
            "rm  \"target[. = 'test_share']/hide unreadable\"",
            "rm  target[. = 'test_share']/path",
            "rm  \"target[. = 'test_share']/read only\"",
            "rm  \"target[. = 'test_share']/public\"",
            "rm  \"target[. = 'test_share']/writable\"",
            "rm  \"target[. = 'test_share']/printable\"",
            "rm  \"target[. = 'test_share']/follow symlinks\"",
            "rm  \"target[. = 'test_share']/wide links\"",
            "set \"target[. = 'test_share']/map acl inherit\" yes",
            "rm  \"target[. = 'test_share']/store dos attributes\"",
            "rm  \"target[. = 'test_share']/strict allocate\"",
            "rm  \"target[. = 'test_share']/valid users\"",
            "rm  \"target[. = 'test_share']/oplocks\"",
            "rm  \"target[. = 'test_share']/level2 oplocks\"",
            "rm  \"target[. = 'test_share']/veto oplock files\"",
            "rm  \"target[. = 'test_share']/write list\"",
            "rm  \"target[. = 'test_share']/hide dot files\"",
            "rm  \"target[. = 'test_share']/root preexec\""
          ],
          :require => 'Augeas[test_share-section]',
          :notify  => 'Class[Samba::Server::Service]')
        }
      end#map_acl_inherit true

      context 'when called with map_acl_inherit set to false' do
        let(:title) { 'test_share' }
        let(:params) {{
          :ensure          => 'present',
          :map_acl_inherit => false,
        }}
        it { is_expected.to contain_samba__server__share('test_share') }
        it { is_expected.to contain_augeas('test_share-section').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => ["set target[. = 'test_share'] 'test_share'"],
          :require => 'Class[Samba::Server::Config]',
          :notify  => 'Class[Samba::Server::Service]')
        }
        it { is_expected.to contain_augeas('test_share-changes').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => [
            "rm  \"target[. = 'test_share']/available\"",
            "rm  \"target[. = 'test_share']/browsable\"",
            "rm  \"target[. = 'test_share']/comment\"",
            "rm  \"target[. = 'test_share']/copy\"",
            "rm  \"target[. = 'test_share']/create mask\"",
            "rm  \"target[. = 'test_share']/directory mask\"",
            "rm  \"target[. = 'test_share']/force create mask\"",
            "rm  \"target[. = 'test_share']/force directory mode\"",
            "rm  \"target[. = 'test_share']/force group\"",
            "rm  \"target[. = 'test_share']/force user\"",
            "rm  \"target[. = 'test_share']/guest ok\"",
            "rm  \"target[. = 'test_share']/guest only\"",
            "rm  \"target[. = 'test_share']/hide unreadable\"",
            "rm  target[. = 'test_share']/path",
            "rm  \"target[. = 'test_share']/read only\"",
            "rm  \"target[. = 'test_share']/public\"",
            "rm  \"target[. = 'test_share']/writable\"",
            "rm  \"target[. = 'test_share']/printable\"",
            "rm  \"target[. = 'test_share']/follow symlinks\"",
            "rm  \"target[. = 'test_share']/wide links\"",
            "set \"target[. = 'test_share']/map acl inherit\" no",
            "rm  \"target[. = 'test_share']/store dos attributes\"",
            "rm  \"target[. = 'test_share']/strict allocate\"",
            "rm  \"target[. = 'test_share']/valid users\"",
            "rm  \"target[. = 'test_share']/oplocks\"",
            "rm  \"target[. = 'test_share']/level2 oplocks\"",
            "rm  \"target[. = 'test_share']/veto oplock files\"",
            "rm  \"target[. = 'test_share']/write list\"",
            "rm  \"target[. = 'test_share']/hide dot files\"",
            "rm  \"target[. = 'test_share']/root preexec\""
          ],
          :require => 'Augeas[test_share-section]',
          :notify  => 'Class[Samba::Server::Service]')
        }
      end#map_acl_inherit false

      context 'when called with store_dos_attributes set to true' do
        let(:title) { 'test_share' }
        let(:params) {{
          :ensure               => 'present',
          :store_dos_attributes => true,
        }}
        it { is_expected.to contain_samba__server__share('test_share') }
        it { is_expected.to contain_augeas('test_share-section').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => ["set target[. = 'test_share'] 'test_share'"],
          :require => 'Class[Samba::Server::Config]',
          :notify  => 'Class[Samba::Server::Service]')
        }
        it { is_expected.to contain_augeas('test_share-changes').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => [
            "rm  \"target[. = 'test_share']/available\"",
            "rm  \"target[. = 'test_share']/browsable\"",
            "rm  \"target[. = 'test_share']/comment\"",
            "rm  \"target[. = 'test_share']/copy\"",
            "rm  \"target[. = 'test_share']/create mask\"",
            "rm  \"target[. = 'test_share']/directory mask\"",
            "rm  \"target[. = 'test_share']/force create mask\"",
            "rm  \"target[. = 'test_share']/force directory mode\"",
            "rm  \"target[. = 'test_share']/force group\"",
            "rm  \"target[. = 'test_share']/force user\"",
            "rm  \"target[. = 'test_share']/guest ok\"",
            "rm  \"target[. = 'test_share']/guest only\"",
            "rm  \"target[. = 'test_share']/hide unreadable\"",
            "rm  target[. = 'test_share']/path",
            "rm  \"target[. = 'test_share']/read only\"",
            "rm  \"target[. = 'test_share']/public\"",
            "rm  \"target[. = 'test_share']/writable\"",
            "rm  \"target[. = 'test_share']/printable\"",
            "rm  \"target[. = 'test_share']/follow symlinks\"",
            "rm  \"target[. = 'test_share']/wide links\"",
            "rm  \"target[. = 'test_share']/map acl inherit\"",
            "set \"target[. = 'test_share']/store dos attributes\" yes",
            "rm  \"target[. = 'test_share']/strict allocate\"",
            "rm  \"target[. = 'test_share']/valid users\"",
            "rm  \"target[. = 'test_share']/oplocks\"",
            "rm  \"target[. = 'test_share']/level2 oplocks\"",
            "rm  \"target[. = 'test_share']/veto oplock files\"",
            "rm  \"target[. = 'test_share']/write list\"",
            "rm  \"target[. = 'test_share']/hide dot files\"",
            "rm  \"target[. = 'test_share']/root preexec\""
          ],
          :require => 'Augeas[test_share-section]',
          :notify  => 'Class[Samba::Server::Service]')
        }
      end#store_dos_attributes true

      context 'when called with store_dos_attributes set to false' do
        let(:title) { 'test_share' }
        let(:params) {{
          :ensure               => 'present',
          :store_dos_attributes => false,
        }}
        it { is_expected.to contain_samba__server__share('test_share') }
        it { is_expected.to contain_augeas('test_share-section').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => ["set target[. = 'test_share'] 'test_share'"],
          :require => 'Class[Samba::Server::Config]',
          :notify  => 'Class[Samba::Server::Service]')
        }
        it { is_expected.to contain_augeas('test_share-changes').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => [
            "rm  \"target[. = 'test_share']/available\"",
            "rm  \"target[. = 'test_share']/browsable\"",
            "rm  \"target[. = 'test_share']/comment\"",
            "rm  \"target[. = 'test_share']/copy\"",
            "rm  \"target[. = 'test_share']/create mask\"",
            "rm  \"target[. = 'test_share']/directory mask\"",
            "rm  \"target[. = 'test_share']/force create mask\"",
            "rm  \"target[. = 'test_share']/force directory mode\"",
            "rm  \"target[. = 'test_share']/force group\"",
            "rm  \"target[. = 'test_share']/force user\"",
            "rm  \"target[. = 'test_share']/guest ok\"",
            "rm  \"target[. = 'test_share']/guest only\"",
            "rm  \"target[. = 'test_share']/hide unreadable\"",
            "rm  target[. = 'test_share']/path",
            "rm  \"target[. = 'test_share']/read only\"",
            "rm  \"target[. = 'test_share']/public\"",
            "rm  \"target[. = 'test_share']/writable\"",
            "rm  \"target[. = 'test_share']/printable\"",
            "rm  \"target[. = 'test_share']/follow symlinks\"",
            "rm  \"target[. = 'test_share']/wide links\"",
            "rm  \"target[. = 'test_share']/map acl inherit\"",
            "set \"target[. = 'test_share']/store dos attributes\" no",
            "rm  \"target[. = 'test_share']/strict allocate\"",
            "rm  \"target[. = 'test_share']/valid users\"",
            "rm  \"target[. = 'test_share']/oplocks\"",
            "rm  \"target[. = 'test_share']/level2 oplocks\"",
            "rm  \"target[. = 'test_share']/veto oplock files\"",
            "rm  \"target[. = 'test_share']/write list\"",
            "rm  \"target[. = 'test_share']/hide dot files\"",
            "rm  \"target[. = 'test_share']/root preexec\""
          ],
          :require => 'Augeas[test_share-section]',
          :notify  => 'Class[Samba::Server::Service]')
        }
      end#store_dos_attributes false

      context 'when called with strict_allocate set to true' do
        let(:title) { 'test_share' }
        let(:params) {{
          :ensure          => 'present',
          :strict_allocate => true,
        }}
        it { is_expected.to contain_samba__server__share('test_share') }
        it { is_expected.to contain_augeas('test_share-section').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => ["set target[. = 'test_share'] 'test_share'"],
          :require => 'Class[Samba::Server::Config]',
          :notify  => 'Class[Samba::Server::Service]')
        }
        it { is_expected.to contain_augeas('test_share-changes').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => [
            "rm  \"target[. = 'test_share']/available\"",
            "rm  \"target[. = 'test_share']/browsable\"",
            "rm  \"target[. = 'test_share']/comment\"",
            "rm  \"target[. = 'test_share']/copy\"",
            "rm  \"target[. = 'test_share']/create mask\"",
            "rm  \"target[. = 'test_share']/directory mask\"",
            "rm  \"target[. = 'test_share']/force create mask\"",
            "rm  \"target[. = 'test_share']/force directory mode\"",
            "rm  \"target[. = 'test_share']/force group\"",
            "rm  \"target[. = 'test_share']/force user\"",
            "rm  \"target[. = 'test_share']/guest ok\"",
            "rm  \"target[. = 'test_share']/guest only\"",
            "rm  \"target[. = 'test_share']/hide unreadable\"",
            "rm  target[. = 'test_share']/path",
            "rm  \"target[. = 'test_share']/read only\"",
            "rm  \"target[. = 'test_share']/public\"",
            "rm  \"target[. = 'test_share']/writable\"",
            "rm  \"target[. = 'test_share']/printable\"",
            "rm  \"target[. = 'test_share']/follow symlinks\"",
            "rm  \"target[. = 'test_share']/wide links\"",
            "rm  \"target[. = 'test_share']/map acl inherit\"",
            "rm  \"target[. = 'test_share']/store dos attributes\"",
            "set \"target[. = 'test_share']/strict allocate\" yes",
            "rm  \"target[. = 'test_share']/valid users\"",
            "rm  \"target[. = 'test_share']/oplocks\"",
            "rm  \"target[. = 'test_share']/level2 oplocks\"",
            "rm  \"target[. = 'test_share']/veto oplock files\"",
            "rm  \"target[. = 'test_share']/write list\"",
            "rm  \"target[. = 'test_share']/hide dot files\"",
            "rm  \"target[. = 'test_share']/root preexec\""
          ],
          :require => 'Augeas[test_share-section]',
          :notify  => 'Class[Samba::Server::Service]')
        }
      end#strict_allocate true

      context 'when called with strict_allocate set to false' do
        let(:title) { 'test_share' }
        let(:params) {{
          :ensure          => 'present',
          :strict_allocate => false,
        }}
        it { is_expected.to contain_samba__server__share('test_share') }
        it { is_expected.to contain_augeas('test_share-section').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => ["set target[. = 'test_share'] 'test_share'"],
          :require => 'Class[Samba::Server::Config]',
          :notify  => 'Class[Samba::Server::Service]')
        }
        it { is_expected.to contain_augeas('test_share-changes').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => [
            "rm  \"target[. = 'test_share']/available\"",
            "rm  \"target[. = 'test_share']/browsable\"",
            "rm  \"target[. = 'test_share']/comment\"",
            "rm  \"target[. = 'test_share']/copy\"",
            "rm  \"target[. = 'test_share']/create mask\"",
            "rm  \"target[. = 'test_share']/directory mask\"",
            "rm  \"target[. = 'test_share']/force create mask\"",
            "rm  \"target[. = 'test_share']/force directory mode\"",
            "rm  \"target[. = 'test_share']/force group\"",
            "rm  \"target[. = 'test_share']/force user\"",
            "rm  \"target[. = 'test_share']/guest ok\"",
            "rm  \"target[. = 'test_share']/guest only\"",
            "rm  \"target[. = 'test_share']/hide unreadable\"",
            "rm  target[. = 'test_share']/path",
            "rm  \"target[. = 'test_share']/read only\"",
            "rm  \"target[. = 'test_share']/public\"",
            "rm  \"target[. = 'test_share']/writable\"",
            "rm  \"target[. = 'test_share']/printable\"",
            "rm  \"target[. = 'test_share']/follow symlinks\"",
            "rm  \"target[. = 'test_share']/wide links\"",
            "rm  \"target[. = 'test_share']/map acl inherit\"",
            "rm  \"target[. = 'test_share']/store dos attributes\"",
            "set \"target[. = 'test_share']/strict allocate\" no",
            "rm  \"target[. = 'test_share']/valid users\"",
            "rm  \"target[. = 'test_share']/oplocks\"",
            "rm  \"target[. = 'test_share']/level2 oplocks\"",
            "rm  \"target[. = 'test_share']/veto oplock files\"",
            "rm  \"target[. = 'test_share']/write list\"",
            "rm  \"target[. = 'test_share']/hide dot files\"",
            "rm  \"target[. = 'test_share']/root preexec\""
          ],
          :require => 'Augeas[test_share-section]',
          :notify  => 'Class[Samba::Server::Service]')
        }
      end#strict_allocate false

      context 'when called with valid_users set to "bill,ben"' do
        let(:title) { 'test_share' }
        let(:params) {{
          :ensure      => 'present',
          :valid_users => 'bill,ben',
        }}
        it { is_expected.to contain_samba__server__share('test_share') }
        it { is_expected.to contain_augeas('test_share-section').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => ["set target[. = 'test_share'] 'test_share'"],
          :require => 'Class[Samba::Server::Config]',
          :notify  => 'Class[Samba::Server::Service]')
        }
        it { is_expected.to contain_augeas('test_share-changes').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => [
            "rm  \"target[. = 'test_share']/available\"",
            "rm  \"target[. = 'test_share']/browsable\"",
            "rm  \"target[. = 'test_share']/comment\"",
            "rm  \"target[. = 'test_share']/copy\"",
            "rm  \"target[. = 'test_share']/create mask\"",
            "rm  \"target[. = 'test_share']/directory mask\"",
            "rm  \"target[. = 'test_share']/force create mask\"",
            "rm  \"target[. = 'test_share']/force directory mode\"",
            "rm  \"target[. = 'test_share']/force group\"",
            "rm  \"target[. = 'test_share']/force user\"",
            "rm  \"target[. = 'test_share']/guest ok\"",
            "rm  \"target[. = 'test_share']/guest only\"",
            "rm  \"target[. = 'test_share']/hide unreadable\"",
            "rm  target[. = 'test_share']/path",
            "rm  \"target[. = 'test_share']/read only\"",
            "rm  \"target[. = 'test_share']/public\"",
            "rm  \"target[. = 'test_share']/writable\"",
            "rm  \"target[. = 'test_share']/printable\"",
            "rm  \"target[. = 'test_share']/follow symlinks\"",
            "rm  \"target[. = 'test_share']/wide links\"",
            "rm  \"target[. = 'test_share']/map acl inherit\"",
            "rm  \"target[. = 'test_share']/store dos attributes\"",
            "rm  \"target[. = 'test_share']/strict allocate\"",
            "set \"target[. = 'test_share']/valid users\" 'bill,ben'",
            "rm  \"target[. = 'test_share']/oplocks\"",
            "rm  \"target[. = 'test_share']/level2 oplocks\"",
            "rm  \"target[. = 'test_share']/veto oplock files\"",
            "rm  \"target[. = 'test_share']/write list\"",
            "rm  \"target[. = 'test_share']/hide dot files\"",
            "rm  \"target[. = 'test_share']/root preexec\""
          ],
          :require => 'Augeas[test_share-section]',
          :notify  => 'Class[Samba::Server::Service]')
        }
      end#valid_users

      context 'when called with op_locks set to "testing"' do
        let(:title) { 'test_share' }
        let(:params) {{
          :ensure   => 'present',
          :op_locks => 'testing',
        }}
        it { is_expected.to contain_samba__server__share('test_share') }
        it { is_expected.to contain_augeas('test_share-section').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => ["set target[. = 'test_share'] 'test_share'"],
          :require => 'Class[Samba::Server::Config]',
          :notify  => 'Class[Samba::Server::Service]')
        }
        it { is_expected.to contain_augeas('test_share-changes').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => [
            "rm  \"target[. = 'test_share']/available\"",
            "rm  \"target[. = 'test_share']/browsable\"",
            "rm  \"target[. = 'test_share']/comment\"",
            "rm  \"target[. = 'test_share']/copy\"",
            "rm  \"target[. = 'test_share']/create mask\"",
            "rm  \"target[. = 'test_share']/directory mask\"",
            "rm  \"target[. = 'test_share']/force create mask\"",
            "rm  \"target[. = 'test_share']/force directory mode\"",
            "rm  \"target[. = 'test_share']/force group\"",
            "rm  \"target[. = 'test_share']/force user\"",
            "rm  \"target[. = 'test_share']/guest ok\"",
            "rm  \"target[. = 'test_share']/guest only\"",
            "rm  \"target[. = 'test_share']/hide unreadable\"",
            "rm  target[. = 'test_share']/path",
            "rm  \"target[. = 'test_share']/read only\"",
            "rm  \"target[. = 'test_share']/public\"",
            "rm  \"target[. = 'test_share']/writable\"",
            "rm  \"target[. = 'test_share']/printable\"",
            "rm  \"target[. = 'test_share']/follow symlinks\"",
            "rm  \"target[. = 'test_share']/wide links\"",
            "rm  \"target[. = 'test_share']/map acl inherit\"",
            "rm  \"target[. = 'test_share']/store dos attributes\"",
            "rm  \"target[. = 'test_share']/strict allocate\"",
            "rm  \"target[. = 'test_share']/valid users\"",
            "set \"target[. = 'test_share']/oplocks\" 'testing'",
            "rm  \"target[. = 'test_share']/level2 oplocks\"",
            "rm  \"target[. = 'test_share']/veto oplock files\"",
            "rm  \"target[. = 'test_share']/write list\"",
            "rm  \"target[. = 'test_share']/hide dot files\"",
            "rm  \"target[. = 'test_share']/root preexec\""
          ],
          :require => 'Augeas[test_share-section]',
          :notify  => 'Class[Samba::Server::Service]')
        }
      end#op_locks

      context 'when called with level2_oplocks set to "testing"' do
        let(:title) { 'test_share' }
        let(:params) {{
          :ensure         => 'present',
          :level2_oplocks => 'testing',
        }}
        it { is_expected.to contain_samba__server__share('test_share') }
        it { is_expected.to contain_augeas('test_share-section').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => ["set target[. = 'test_share'] 'test_share'"],
          :require => 'Class[Samba::Server::Config]',
          :notify  => 'Class[Samba::Server::Service]')
        }
        it { is_expected.to contain_augeas('test_share-changes').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => [
            "rm  \"target[. = 'test_share']/available\"",
            "rm  \"target[. = 'test_share']/browsable\"",
            "rm  \"target[. = 'test_share']/comment\"",
            "rm  \"target[. = 'test_share']/copy\"",
            "rm  \"target[. = 'test_share']/create mask\"",
            "rm  \"target[. = 'test_share']/directory mask\"",
            "rm  \"target[. = 'test_share']/force create mask\"",
            "rm  \"target[. = 'test_share']/force directory mode\"",
            "rm  \"target[. = 'test_share']/force group\"",
            "rm  \"target[. = 'test_share']/force user\"",
            "rm  \"target[. = 'test_share']/guest ok\"",
            "rm  \"target[. = 'test_share']/guest only\"",
            "rm  \"target[. = 'test_share']/hide unreadable\"",
            "rm  target[. = 'test_share']/path",
            "rm  \"target[. = 'test_share']/read only\"",
            "rm  \"target[. = 'test_share']/public\"",
            "rm  \"target[. = 'test_share']/writable\"",
            "rm  \"target[. = 'test_share']/printable\"",
            "rm  \"target[. = 'test_share']/follow symlinks\"",
            "rm  \"target[. = 'test_share']/wide links\"",
            "rm  \"target[. = 'test_share']/map acl inherit\"",
            "rm  \"target[. = 'test_share']/store dos attributes\"",
            "rm  \"target[. = 'test_share']/strict allocate\"",
            "rm  \"target[. = 'test_share']/valid users\"",
            "rm  \"target[. = 'test_share']/oplocks\"",
            "set \"target[. = 'test_share']/level2 oplocks\" 'testing'",
            "rm  \"target[. = 'test_share']/veto oplock files\"",
            "rm  \"target[. = 'test_share']/write list\"",
            "rm  \"target[. = 'test_share']/hide dot files\"",
            "rm  \"target[. = 'test_share']/root preexec\""
          ],
          :require => 'Augeas[test_share-section]',
          :notify  => 'Class[Samba::Server::Service]')
        }
      end#level2_oplocks

      context 'when called with veto_oplock_files set to "testing"' do
        let(:title) { 'test_share' }
        let(:params) {{
          :ensure            => 'present',
          :veto_oplock_files => 'testing',
        }}
        it { is_expected.to contain_samba__server__share('test_share') }
        it { is_expected.to contain_augeas('test_share-section').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => ["set target[. = 'test_share'] 'test_share'"],
          :require => 'Class[Samba::Server::Config]',
          :notify  => 'Class[Samba::Server::Service]')
        }
        it { is_expected.to contain_augeas('test_share-changes').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => [
            "rm  \"target[. = 'test_share']/available\"",
            "rm  \"target[. = 'test_share']/browsable\"",
            "rm  \"target[. = 'test_share']/comment\"",
            "rm  \"target[. = 'test_share']/copy\"",
            "rm  \"target[. = 'test_share']/create mask\"",
            "rm  \"target[. = 'test_share']/directory mask\"",
            "rm  \"target[. = 'test_share']/force create mask\"",
            "rm  \"target[. = 'test_share']/force directory mode\"",
            "rm  \"target[. = 'test_share']/force group\"",
            "rm  \"target[. = 'test_share']/force user\"",
            "rm  \"target[. = 'test_share']/guest ok\"",
            "rm  \"target[. = 'test_share']/guest only\"",
            "rm  \"target[. = 'test_share']/hide unreadable\"",
            "rm  target[. = 'test_share']/path",
            "rm  \"target[. = 'test_share']/read only\"",
            "rm  \"target[. = 'test_share']/public\"",
            "rm  \"target[. = 'test_share']/writable\"",
            "rm  \"target[. = 'test_share']/printable\"",
            "rm  \"target[. = 'test_share']/follow symlinks\"",
            "rm  \"target[. = 'test_share']/wide links\"",
            "rm  \"target[. = 'test_share']/map acl inherit\"",
            "rm  \"target[. = 'test_share']/store dos attributes\"",
            "rm  \"target[. = 'test_share']/strict allocate\"",
            "rm  \"target[. = 'test_share']/valid users\"",
            "rm  \"target[. = 'test_share']/oplocks\"",
            "rm  \"target[. = 'test_share']/level2 oplocks\"",
            "set \"target[. = 'test_share']/veto oplock files\" 'testing'",
            "rm  \"target[. = 'test_share']/write list\"",
            "rm  \"target[. = 'test_share']/hide dot files\"",
            "rm  \"target[. = 'test_share']/root preexec\""
          ],
          :require => 'Augeas[test_share-section]',
          :notify  => 'Class[Samba::Server::Service]')
        }
      end#veto_oplock_files

      context 'when called with write_list set to "bill,ben"' do
        let(:title) { 'test_share' }
        let(:params) {{
          :ensure     => 'present',
          :write_list => 'bill,ben',
        }}
        it { is_expected.to contain_samba__server__share('test_share') }
        it { is_expected.to contain_augeas('test_share-section').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => ["set target[. = 'test_share'] 'test_share'"],
          :require => 'Class[Samba::Server::Config]',
          :notify  => 'Class[Samba::Server::Service]')
        }
        it { is_expected.to contain_augeas('test_share-changes').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => [
            "rm  \"target[. = 'test_share']/available\"",
            "rm  \"target[. = 'test_share']/browsable\"",
            "rm  \"target[. = 'test_share']/comment\"",
            "rm  \"target[. = 'test_share']/copy\"",
            "rm  \"target[. = 'test_share']/create mask\"",
            "rm  \"target[. = 'test_share']/directory mask\"",
            "rm  \"target[. = 'test_share']/force create mask\"",
            "rm  \"target[. = 'test_share']/force directory mode\"",
            "rm  \"target[. = 'test_share']/force group\"",
            "rm  \"target[. = 'test_share']/force user\"",
            "rm  \"target[. = 'test_share']/guest ok\"",
            "rm  \"target[. = 'test_share']/guest only\"",
            "rm  \"target[. = 'test_share']/hide unreadable\"",
            "rm  target[. = 'test_share']/path",
            "rm  \"target[. = 'test_share']/read only\"",
            "rm  \"target[. = 'test_share']/public\"",
            "rm  \"target[. = 'test_share']/writable\"",
            "rm  \"target[. = 'test_share']/printable\"",
            "rm  \"target[. = 'test_share']/follow symlinks\"",
            "rm  \"target[. = 'test_share']/wide links\"",
            "rm  \"target[. = 'test_share']/map acl inherit\"",
            "rm  \"target[. = 'test_share']/store dos attributes\"",
            "rm  \"target[. = 'test_share']/strict allocate\"",
            "rm  \"target[. = 'test_share']/valid users\"",
            "rm  \"target[. = 'test_share']/oplocks\"",
            "rm  \"target[. = 'test_share']/level2 oplocks\"",
            "rm  \"target[. = 'test_share']/veto oplock files\"",
            "set \"target[. = 'test_share']/write list\" 'bill,ben'",
            "rm  \"target[. = 'test_share']/hide dot files\"",
            "rm  \"target[. = 'test_share']/root preexec\""
          ],
          :require => 'Augeas[test_share-section]',
          :notify  => 'Class[Samba::Server::Service]')
        }
      end#write_list

      context 'when called with hide_dot_files set to true' do
        let(:title) { 'test_share' }
        let(:params) {{
          :ensure         => 'present',
          :hide_dot_files => true,
        }}
        it { is_expected.to contain_samba__server__share('test_share') }
        it { is_expected.to contain_augeas('test_share-section').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => ["set target[. = 'test_share'] 'test_share'"],
          :require => 'Class[Samba::Server::Config]',
          :notify  => 'Class[Samba::Server::Service]')
        }
        it { is_expected.to contain_augeas('test_share-changes').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => [
            "rm  \"target[. = 'test_share']/available\"",
            "rm  \"target[. = 'test_share']/browsable\"",
            "rm  \"target[. = 'test_share']/comment\"",
            "rm  \"target[. = 'test_share']/copy\"",
            "rm  \"target[. = 'test_share']/create mask\"",
            "rm  \"target[. = 'test_share']/directory mask\"",
            "rm  \"target[. = 'test_share']/force create mask\"",
            "rm  \"target[. = 'test_share']/force directory mode\"",
            "rm  \"target[. = 'test_share']/force group\"",
            "rm  \"target[. = 'test_share']/force user\"",
            "rm  \"target[. = 'test_share']/guest ok\"",
            "rm  \"target[. = 'test_share']/guest only\"",
            "rm  \"target[. = 'test_share']/hide unreadable\"",
            "rm  target[. = 'test_share']/path",
            "rm  \"target[. = 'test_share']/read only\"",
            "rm  \"target[. = 'test_share']/public\"",
            "rm  \"target[. = 'test_share']/writable\"",
            "rm  \"target[. = 'test_share']/printable\"",
            "rm  \"target[. = 'test_share']/follow symlinks\"",
            "rm  \"target[. = 'test_share']/wide links\"",
            "rm  \"target[. = 'test_share']/map acl inherit\"",
            "rm  \"target[. = 'test_share']/store dos attributes\"",
            "rm  \"target[. = 'test_share']/strict allocate\"",
            "rm  \"target[. = 'test_share']/valid users\"",
            "rm  \"target[. = 'test_share']/oplocks\"",
            "rm  \"target[. = 'test_share']/level2 oplocks\"",
            "rm  \"target[. = 'test_share']/veto oplock files\"",
            "rm  \"target[. = 'test_share']/write list\"",
            "set \"target[. = 'test_share']/hide dot files\" yes",
            "rm  \"target[. = 'test_share']/root preexec\""
          ],
          :require => 'Augeas[test_share-section]',
          :notify  => 'Class[Samba::Server::Service]')
        }
      end#hide_dot_files true

      context 'when called with hide_dot_files set to false' do
        let(:title) { 'test_share' }
        let(:params) {{
          :ensure         => 'present',
          :hide_dot_files => false,
        }}
        it { is_expected.to contain_samba__server__share('test_share') }
        it { is_expected.to contain_augeas('test_share-section').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => ["set target[. = 'test_share'] 'test_share'"],
          :require => 'Class[Samba::Server::Config]',
          :notify  => 'Class[Samba::Server::Service]')
        }
        it { is_expected.to contain_augeas('test_share-changes').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => [
            "rm  \"target[. = 'test_share']/available\"",
            "rm  \"target[. = 'test_share']/browsable\"",
            "rm  \"target[. = 'test_share']/comment\"",
            "rm  \"target[. = 'test_share']/copy\"",
            "rm  \"target[. = 'test_share']/create mask\"",
            "rm  \"target[. = 'test_share']/directory mask\"",
            "rm  \"target[. = 'test_share']/force create mask\"",
            "rm  \"target[. = 'test_share']/force directory mode\"",
            "rm  \"target[. = 'test_share']/force group\"",
            "rm  \"target[. = 'test_share']/force user\"",
            "rm  \"target[. = 'test_share']/guest ok\"",
            "rm  \"target[. = 'test_share']/guest only\"",
            "rm  \"target[. = 'test_share']/hide unreadable\"",
            "rm  target[. = 'test_share']/path",
            "rm  \"target[. = 'test_share']/read only\"",
            "rm  \"target[. = 'test_share']/public\"",
            "rm  \"target[. = 'test_share']/writable\"",
            "rm  \"target[. = 'test_share']/printable\"",
            "rm  \"target[. = 'test_share']/follow symlinks\"",
            "rm  \"target[. = 'test_share']/wide links\"",
            "rm  \"target[. = 'test_share']/map acl inherit\"",
            "rm  \"target[. = 'test_share']/store dos attributes\"",
            "rm  \"target[. = 'test_share']/strict allocate\"",
            "rm  \"target[. = 'test_share']/valid users\"",
            "rm  \"target[. = 'test_share']/oplocks\"",
            "rm  \"target[. = 'test_share']/level2 oplocks\"",
            "rm  \"target[. = 'test_share']/veto oplock files\"",
            "rm  \"target[. = 'test_share']/write list\"",
            "set \"target[. = 'test_share']/hide dot files\" no",
            "rm  \"target[. = 'test_share']/root preexec\""
          ],
          :require => 'Augeas[test_share-section]',
          :notify  => 'Class[Samba::Server::Service]')
        }
      end#hide_dot_files false

      context 'when called with root_preexec set to "/bin/test"' do
        let(:title) { 'test_share' }
        let(:params) {{
          :ensure       => 'present',
          :root_preexec => '/bin/test',
        }}
        it { is_expected.to contain_samba__server__share('test_share') }
        it { is_expected.to contain_augeas('test_share-section').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => ["set target[. = 'test_share'] 'test_share'"],
          :require => 'Class[Samba::Server::Config]',
          :notify  => 'Class[Samba::Server::Service]')
        }
        it { is_expected.to contain_augeas('test_share-changes').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => [
            "rm  \"target[. = 'test_share']/available\"",
            "rm  \"target[. = 'test_share']/browsable\"",
            "rm  \"target[. = 'test_share']/comment\"",
            "rm  \"target[. = 'test_share']/copy\"",
            "rm  \"target[. = 'test_share']/create mask\"",
            "rm  \"target[. = 'test_share']/directory mask\"",
            "rm  \"target[. = 'test_share']/force create mask\"",
            "rm  \"target[. = 'test_share']/force directory mode\"",
            "rm  \"target[. = 'test_share']/force group\"",
            "rm  \"target[. = 'test_share']/force user\"",
            "rm  \"target[. = 'test_share']/guest ok\"",
            "rm  \"target[. = 'test_share']/guest only\"",
            "rm  \"target[. = 'test_share']/hide unreadable\"",
            "rm  target[. = 'test_share']/path",
            "rm  \"target[. = 'test_share']/read only\"",
            "rm  \"target[. = 'test_share']/public\"",
            "rm  \"target[. = 'test_share']/writable\"",
            "rm  \"target[. = 'test_share']/printable\"",
            "rm  \"target[. = 'test_share']/follow symlinks\"",
            "rm  \"target[. = 'test_share']/wide links\"",
            "rm  \"target[. = 'test_share']/map acl inherit\"",
            "rm  \"target[. = 'test_share']/store dos attributes\"",
            "rm  \"target[. = 'test_share']/strict allocate\"",
            "rm  \"target[. = 'test_share']/valid users\"",
            "rm  \"target[. = 'test_share']/oplocks\"",
            "rm  \"target[. = 'test_share']/level2 oplocks\"",
            "rm  \"target[. = 'test_share']/veto oplock files\"",
            "rm  \"target[. = 'test_share']/write list\"",
            "rm  \"target[. = 'test_share']/hide dot files\"",
            "set \"target[. = 'test_share']/root preexec\" '/bin/test'"
          ],
          :require => 'Augeas[test_share-section]',
          :notify  => 'Class[Samba::Server::Service]')
        }
      end#root_preexec

    end
  end
end

