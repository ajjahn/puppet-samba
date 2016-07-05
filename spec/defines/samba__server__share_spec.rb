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

    end
  end
end

