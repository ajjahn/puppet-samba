require 'spec_helper'

shared_examples "default share" do
  let(:title) { "test_share" }
  let(:params) {{ :ensure => 'present' }}
  let(:default_changes) do
    set = Augeas::TargetedChangeSet.new(title)
    set.with("available")
    set.with("browsable")
    set.with("comment")
    set.with("copy")
    set.with("create mask")
    set.with("directory mask")
    set.with("force create mask")
    set.with("force directory mode")
    set.with("force group")
    set.with("force user")
    set.with("guest ok")
    set.with("guest only")
    set.with("hide unreadable")
    set.with("path", nil, nil)
    set.with("read only")
    set.with("public")
    set.with("writable")
    set.with("printable")
    set.with("follow symlinks")
    set.with("wide links")
    set.with("map acl inherit")
    set.with("store dos attributes")
    set.with("strict allocate")
    set.with("valid users")
    set.with("oplocks")
    set.with("level2 oplocks")
    set.with("veto oplock files")
    set.with("write list")
    set.with("hide dot files")
    set.with("root preexec")
  end
  let(:change_set) { default_changes }
  let(:changes) { change_set.to_a }

  it { is_expected.to contain_samba__server__share(title) }
  it { is_expected.to contain_augeas("#{title}-section").with(
    :incl    => '/etc/samba/smb.conf',
    :lens    => 'Samba.lns',
    :context => '/files/etc/samba/smb.conf',
    :changes => ["set target[. = '#{title}'] '#{title}'"],
    :require => 'Class[Samba::Server::Config]',
    :notify  => 'Class[Samba::Server::Service]')
  }
  it { is_expected.to contain_augeas("#{title}-changes").with(
    :incl    => '/etc/samba/smb.conf',
    :lens    => 'Samba.lns',
    :context => '/files/etc/samba/smb.conf',
    :changes => changes,
    :require => 'Augeas[test_share-section]',
    :notify  => 'Class[Samba::Server::Service]')
  }
end

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
        include_examples "default share"
        let(:params) {{
          :ensure    => 'present',
          :available => true,
        }}
        let(:change_set) { default_changes.with("available", "yes") }
      end#available true

      context 'when called with available set to false' do
        include_examples "default share"
        let(:params) {{
          :ensure    => 'present',
          :available => false,
        }}
        let(:change_set) { default_changes.with("available", "no") }
      end#available false

      context 'when called with browsable set to true' do
        include_examples "default share"
        let(:params) {{
          :ensure    => 'present',
          :browsable => true,
        }}
        let(:change_set) { default_changes.with("browsable", "yes") }
      end#browsable false

      context 'when called with browsable set to false' do
        include_examples "default share"
        let(:params) {{
          :ensure    => 'present',
          :browsable => false,
        }}
        let(:change_set) { default_changes.with("browsable", "no") }
      end#browsable false

      context 'when called with root_preexec set to /bin/true' do
        include_examples "default share"
        let(:params) {{
          :ensure    => 'present',
          :root_preexec => '/bin/true',
        }}
        let(:change_set) { default_changes.with("root preexec", "'/bin/true'") }
      end#root_preexec

      context 'when called with comment set to "testing testing"' do
        include_examples "default share"
        let(:params) {{
          :ensure    => 'present',
          :comment => 'testing testing',
        }}
        let(:change_set) { default_changes.with("comment", "'testing testing'") }
      end#comment

      context 'when called with copy set to "testing testing"' do
        include_examples "default share"
        let(:params) {{
          :ensure    => 'present',
          :copy => 'testing testing',
        }}
        let(:change_set) { default_changes.with("copy", "'testing testing'") }
      end#copy

      context 'when called with create_mask set to "755"' do
        include_examples "default share"
        let(:params) {{
          :ensure    => 'present',
          :create_mask => '755',
        }}
        let(:change_set) { default_changes.with("create mask", "'755'") }
      end#create mask

      context 'when called with directory_mask set to "755"' do
        include_examples "default share"
        let(:params) {{
          :ensure    => 'present',
          :directory_mask => '755',
        }}
        let(:change_set) { default_changes.with("directory mask", "'755'") }
      end#directory_mask

      context 'when called with force_create_mask set to "755"' do
        include_examples "default share"
        let(:params) {{
          :ensure    => 'present',
          :force_create_mask => '755',
        }}
        let(:change_set) { default_changes.with("force create mask", "'755'") }
      end#force_create_mask

      context 'when called with force_directory_mode set to "755"' do
        include_examples "default share"
        let(:params) {{
          :ensure    => 'present',
          :force_directory_mode => '755',
        }}
        let(:change_set) { default_changes.with("force directory mode", "'755'") }
      end#force_directory_mode

      context 'when called with force_group set to "nogroup"' do
        include_examples "default share"
        let(:params) {{
          :ensure    => 'present',
          :force_group => 'nogroup',
        }}
        let(:change_set) { default_changes.with("force group", "'nogroup'") }
      end#force_group

      context 'when called with force_user set to "nobody"' do
        include_examples "default share"
        let(:params) {{
          :ensure    => 'present',
          :force_user => 'nobody',
        }}
        let(:change_set) { default_changes.with("force user", "'nobody'") }
      end#force_user

      context 'when called with guest_ok set to true' do
        include_examples "default share"
        let(:params) {{
          :ensure   => 'present',
          :guest_ok => true,
        }}
        let(:change_set) { default_changes.with("guest ok", "yes") }
      end#guest_ok true

      context 'when called with guest_ok set to false' do
        include_examples "default share"
        let(:params) {{
          :ensure   => 'present',
          :guest_ok => false,
        }}
        let(:change_set) { default_changes.with("guest ok", "no") }
      end#guest_ok false

      context 'when called with guest_only set to true' do
        include_examples "default share"
        let(:params) {{
          :ensure     => 'present',
          :guest_only => true,
        }}
        let(:change_set) { default_changes.with("guest only", "yes") }
      end#guest_only false

      context 'when called with guest_only set to false' do
        include_examples "default share"
        let(:params) {{
          :ensure     => 'present',
          :guest_only => false,
        }}
        let(:change_set) { default_changes.with("guest only", "no") }
      end#guest_only false

      context 'when called with hide_unreadable set to true' do
        include_examples "default share"
        let(:params) {{
          :ensure          => 'present',
          :hide_unreadable => true,
        }}
        let(:change_set) { default_changes.with("hide unreadable", "yes") }
      end#hide_unreadable true

      context 'when called with hide_unreadable set to false' do
        include_examples "default share"
        let(:params) {{
          :ensure          => 'present',
          :hide_unreadable => false,
        }}
        let(:change_set) { default_changes.with("hide unreadable", "no") }
      end#hide_unreadable false

      context 'when called with path set to /tmp' do
        include_examples "default share"
        let(:params) {{
          :ensure => 'present',
          :path   => '/tmp',
        }}
        let(:change_set) { default_changes.with("path", "'/tmp'", nil) }
      end#path

      context 'when called with read_only set to true' do
        include_examples "default share"
        let(:params) {{
          :ensure    => 'present',
          :read_only => true,
        }}
        let(:change_set) { default_changes.with("read only", "yes") }
      end#read_only true

      context 'when called with read_only set to false' do
        include_examples "default share"
        let(:params) {{
          :ensure    => 'present',
          :read_only => false,
        }}
        let(:change_set) { default_changes.with("read only", "no") }
      end#read_only false

      context 'when called with public set to true' do
        include_examples "default share"
        let(:params) {{
          :ensure => 'present',
          :public => true,
        }}
        let(:change_set) { default_changes.with("public", "yes") }
      end#public true

      context 'when called with public set to false' do
        include_examples "default share"
        let(:params) {{
          :ensure => 'present',
          :public => false,
        }}
        let(:change_set) { default_changes.with("public", "no") }
      end#public false

      context 'when called with writable set to true' do
        include_examples "default share"
        let(:params) {{
          :ensure   => 'present',
          :writable => true,
        }}
        let(:change_set) { default_changes.with("writable", "yes") }
      end#writable true

      context 'when called with writable set to false' do
        include_examples "default share"
        let(:params) {{
          :ensure   => 'present',
          :writable => false,
        }}
        let(:change_set) { default_changes.with("writable", "no") }
      end#writable false

      context 'when called with printable set to true' do
        include_examples "default share"
        let(:params) {{
          :ensure    => 'present',
          :printable => true,
        }}
        let(:change_set) { default_changes.with("printable", "yes") }
      end#printable true

      context 'when called with printable set to false' do
        include_examples "default share"
        let(:params) {{
          :ensure    => 'present',
          :printable => false,
        }}
        let(:change_set) { default_changes.with("printable", "no") }
      end#printable false

      context 'when called with follow_symlinks set to true' do
        include_examples "default share"
        let(:params) {{
          :ensure          => 'present',
          :follow_symlinks => true,
        }}
        let(:change_set) { default_changes.with("follow symlinks", "yes") }
      end#follow_symlinks true

      context 'when called with follow_symlinks set to false' do
        include_examples "default share"
        let(:params) {{
          :ensure          => 'present',
          :follow_symlinks => false,
        }}
        let(:change_set) { default_changes.with("follow symlinks", "no") }
      end#follow_symlinks false

      context 'when called with wide_links set to true' do
        include_examples "default share"
        let(:params) {{
          :ensure     => 'present',
          :wide_links => true,
        }}
        let(:change_set) { default_changes.with("wide links", "yes") }
      end#wide_links true

      context 'when called with wide_links set to false' do
        include_examples "default share"
        let(:params) {{
          :ensure     => 'present',
          :wide_links => false,
        }}
        let(:change_set) { default_changes.with("wide links", "no") }
      end#wide_links false

      context 'when called with map_acl_inherit set to true' do
        include_examples "default share"
        let(:params) {{
          :ensure          => 'present',
          :map_acl_inherit => true,
        }}
        let(:change_set) { default_changes.with("map acl inherit", "yes") }
      end#map_acl_inherit true

      context 'when called with map_acl_inherit set to false' do
        include_examples "default share"
        let(:params) {{
          :ensure          => 'present',
          :map_acl_inherit => false,
        }}
        let(:change_set) { default_changes.with("map acl inherit", "no") }
      end#map_acl_inherit false

      context 'when called with store_dos_attributes set to true' do
        include_examples "default share"
        let(:params) {{
          :ensure               => 'present',
          :store_dos_attributes => true,
        }}
        let(:change_set) { default_changes.with("store dos attributes", "yes") }
      end#store_dos_attributes true

      context 'when called with store_dos_attributes set to false' do
        include_examples "default share"
        let(:params) {{
          :ensure               => 'present',
          :store_dos_attributes => false,
        }}
        let(:change_set) { default_changes.with("store dos attributes", "no") }
      end#store_dos_attributes false

      context 'when called with strict_allocate set to true' do
        include_examples "default share"
        let(:params) {{
          :ensure          => 'present',
          :strict_allocate => true,
        }}
        let(:change_set) { default_changes.with("strict allocate", "yes") }
      end#strict_allocate true

      context 'when called with strict_allocate set to false' do
        include_examples "default share"
        let(:params) {{
          :ensure          => 'present',
          :strict_allocate => false,
        }}
        let(:change_set) { default_changes.with("strict allocate", "no") }
      end#strict_allocate false

      context 'when called with valid_users set to "bill,ben"' do
        include_examples "default share"
        let(:params) {{
          :ensure      => 'present',
          :valid_users => 'bill,ben',
        }}
        let(:change_set) { default_changes.with("valid users", "'bill,ben'") }
      end#valid_users

      context 'when called with op_locks set to "testing"' do
        include_examples "default share"
        let(:params) {{
          :ensure   => 'present',
          :op_locks => 'testing',
        }}
        let(:change_set) { default_changes.with("oplocks", "'testing'") }
      end#op_locks

      context 'when called with level2_oplocks set to "testing"' do
        include_examples "default share"
        let(:params) {{
          :ensure         => 'present',
          :level2_oplocks => 'testing',
        }}
        let(:change_set) { default_changes.with("level2 oplocks", "'testing'") }
      end#level2_oplocks

      context 'when called with veto_oplock_files set to "testing"' do
        include_examples "default share"
        let(:params) {{
          :ensure            => 'present',
          :veto_oplock_files => 'testing',
        }}
        let(:change_set) { default_changes.with("veto oplock files", "'testing'") }
      end#veto_oplock_files

      context 'when called with write_list set to "bill,ben"' do
        include_examples "default share"
        let(:params) {{
          :ensure     => 'present',
          :write_list => 'bill,ben',
        }}
        let(:change_set) { default_changes.with("write list", "'bill,ben'") }
      end#write_list

      context 'when called with hide_dot_files set to true' do
        include_examples "default share"
        let(:params) {{
          :ensure         => 'present',
          :hide_dot_files => true,
        }}
        let(:change_set) { default_changes.with("hide dot files", "yes") }
      end#hide_dot_files true

      context 'when called with hide_dot_files set to false' do
        include_examples "default share"
        let(:params) {{
          :ensure         => 'present',
          :hide_dot_files => false,
        }}
        let(:change_set) { default_changes.with("hide dot files", "no") }
      end#hide_dot_files false

      context 'when called with root_preexec set to "/bin/test"' do
        include_examples "default share"
        let(:params) {{
          :ensure       => 'present',
          :root_preexec => '/bin/test',
        }}
        let(:change_set) { default_changes.with("root preexec", "'/bin/test'") }
      end#root_preexec
    end
  end
end
