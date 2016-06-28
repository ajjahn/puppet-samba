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
    set.with("profile acls")
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
    context "for #{os}" do
      let(:facts) do
        facts.merge({
          :concat_basedir => '/tmp',
          :domain => 'domain.com'
        })
      end

      context 'with base options' do
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
      end

      context 'with ensure set to absent' do
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
      end

      context 'with available set to true' do
        include_examples "default share"
        let(:params) {{
          :ensure    => 'present',
          :available => true,
        }}
        let(:change_set) { default_changes.with("available", "yes") }
      end

      context 'with available set to false' do
        include_examples "default share"
        let(:params) {{
          :ensure    => 'present',
          :available => false,
        }}
        let(:change_set) { default_changes.with("available", "no") }
      end

      context 'with browsable set to true' do
        include_examples "default share"
        let(:params) {{
          :ensure    => 'present',
          :browsable => true,
        }}
        let(:change_set) { default_changes.with("browsable", "yes") }
      end

      context 'with browsable set to false' do
        include_examples "default share"
        let(:params) {{
          :ensure    => 'present',
          :browsable => false,
        }}
        let(:change_set) { default_changes.with("browsable", "no") }
      end

      context 'with root_preexec set to /bin/true' do
        include_examples "default share"
        let(:params) {{
          :ensure    => 'present',
          :root_preexec => '/bin/true',
        }}
        let(:change_set) { default_changes.with("root preexec", "'/bin/true'") }
      end

      context 'with comment set to "testing testing"' do
        include_examples "default share"
        let(:params) {{
          :ensure    => 'present',
          :comment => 'testing testing',
        }}
        let(:change_set) { default_changes.with("comment", "'testing testing'") }
      end

      context 'with copy set to "testing testing"' do
        include_examples "default share"
        let(:params) {{
          :ensure    => 'present',
          :copy => 'testing testing',
        }}
        let(:change_set) { default_changes.with("copy", "'testing testing'") }
      end

      context 'with create_mask set to "755"' do
        include_examples "default share"
        let(:params) {{
          :ensure    => 'present',
          :create_mask => '755',
        }}
        let(:change_set) { default_changes.with("create mask", "'755'") }
      end

      context 'with directory_mask set to "755"' do
        include_examples "default share"
        let(:params) {{
          :ensure    => 'present',
          :directory_mask => '755',
        }}
        let(:change_set) { default_changes.with("directory mask", "'755'") }
      end

      context 'with force_create_mask set to "755"' do
        include_examples "default share"
        let(:params) {{
          :ensure    => 'present',
          :force_create_mask => '755',
        }}
        let(:change_set) { default_changes.with("force create mask", "'755'") }
      end

      context 'with force_directory_mode set to "755"' do
        include_examples "default share"
        let(:params) {{
          :ensure    => 'present',
          :force_directory_mode => '755',
        }}
        let(:change_set) { default_changes.with("force directory mode", "'755'") }
      end

      context 'with force_group set to "nogroup"' do
        include_examples "default share"
        let(:params) {{
          :ensure    => 'present',
          :force_group => 'nogroup',
        }}
        let(:change_set) { default_changes.with("force group", "'nogroup'") }
      end

      context 'with force_user set to "nobody"' do
        include_examples "default share"
        let(:params) {{
          :ensure    => 'present',
          :force_user => 'nobody',
        }}
        let(:change_set) { default_changes.with("force user", "'nobody'") }
      end

      context 'with guest_ok set to true' do
        include_examples "default share"
        let(:params) {{
          :ensure   => 'present',
          :guest_ok => true,
        }}
        let(:change_set) { default_changes.with("guest ok", "yes") }
      end

      context 'with guest_ok set to false' do
        include_examples "default share"
        let(:params) {{
          :ensure   => 'present',
          :guest_ok => false,
        }}
        let(:change_set) { default_changes.with("guest ok", "no") }
      end

      context 'with guest_only set to true' do
        include_examples "default share"
        let(:params) {{
          :ensure     => 'present',
          :guest_only => true,
        }}
        let(:change_set) { default_changes.with("guest only", "yes") }
      end

      context 'with guest_only set to false' do
        include_examples "default share"
        let(:params) {{
          :ensure     => 'present',
          :guest_only => false,
        }}
        let(:change_set) { default_changes.with("guest only", "no") }
      end

      context 'with hide_unreadable set to true' do
        include_examples "default share"
        let(:params) {{
          :ensure          => 'present',
          :hide_unreadable => true,
        }}
        let(:change_set) { default_changes.with("hide unreadable", "yes") }
      end

      context 'with hide_unreadable set to false' do
        include_examples "default share"
        let(:params) {{
          :ensure          => 'present',
          :hide_unreadable => false,
        }}
        let(:change_set) { default_changes.with("hide unreadable", "no") }
      end

      context 'with path set to /tmp' do
        include_examples "default share"
        let(:params) {{
          :ensure => 'present',
          :path   => '/tmp',
        }}
        let(:change_set) { default_changes.with("path", "'/tmp'", nil) }
      end

      context 'with read_only set to true' do
        include_examples "default share"
        let(:params) {{
          :ensure    => 'present',
          :read_only => true,
        }}
        let(:change_set) { default_changes.with("read only", "yes") }
      end

      context 'with read_only set to false' do
        include_examples "default share"
        let(:params) {{
          :ensure    => 'present',
          :read_only => false,
        }}
        let(:change_set) { default_changes.with("read only", "no") }
      end

      context 'with public set to true' do
        include_examples "default share"
        let(:params) {{
          :ensure => 'present',
          :public => true,
        }}
        let(:change_set) { default_changes.with("public", "yes") }
      end

      context 'with public set to false' do
        include_examples "default share"
        let(:params) {{
          :ensure => 'present',
          :public => false,
        }}
        let(:change_set) { default_changes.with("public", "no") }
      end

      context 'with writable set to true' do
        include_examples "default share"
        let(:params) {{
          :ensure   => 'present',
          :writable => true,
        }}
        let(:change_set) { default_changes.with("writable", "yes") }
      end

      context 'with writable set to false' do
        include_examples "default share"
        let(:params) {{
          :ensure   => 'present',
          :writable => false,
        }}
        let(:change_set) { default_changes.with("writable", "no") }
      end

      context 'with printable set to true' do
        include_examples "default share"
        let(:params) {{
          :ensure    => 'present',
          :printable => true,
        }}
        let(:change_set) { default_changes.with("printable", "yes") }
      end

      context 'with printable set to false' do
        include_examples "default share"
        let(:params) {{
          :ensure    => 'present',
          :printable => false,
        }}
        let(:change_set) { default_changes.with("printable", "no") }
      end

      context 'with follow_symlinks set to true' do
        include_examples "default share"
        let(:params) {{
          :ensure          => 'present',
          :follow_symlinks => true,
        }}
        let(:change_set) { default_changes.with("follow symlinks", "yes") }
      end

      context 'with follow_symlinks set to false' do
        include_examples "default share"
        let(:params) {{
          :ensure          => 'present',
          :follow_symlinks => false,
        }}
        let(:change_set) { default_changes.with("follow symlinks", "no") }
      end

      context 'with wide_links set to true' do
        include_examples "default share"
        let(:params) {{
          :ensure     => 'present',
          :wide_links => true,
        }}
        let(:change_set) { default_changes.with("wide links", "yes") }
      end

      context 'with wide_links set to false' do
        include_examples "default share"
        let(:params) {{
          :ensure     => 'present',
          :wide_links => false,
        }}
        let(:change_set) { default_changes.with("wide links", "no") }
      end

      context 'with map_acl_inherit set to true' do
        include_examples "default share"
        let(:params) {{
          :ensure          => 'present',
          :map_acl_inherit => true,
        }}
        let(:change_set) { default_changes.with("map acl inherit", "yes") }
      end

      context 'with map_acl_inherit set to false' do
        include_examples "default share"
        let(:params) {{
          :ensure          => 'present',
          :map_acl_inherit => false,
        }}
        let(:change_set) { default_changes.with("map acl inherit", "no") }
      end

      context 'with profile_acls set to true' do
        include_examples "default share"
        let(:params) {{
          :ensure          => 'present',
          :profile_acls    => true,
        }}
        let(:change_set) { default_changes.with("profile acls", "yes") }
      end

      context 'with profile_acls set to false' do
        include_examples "default share"
        let(:params) {{
          :ensure          => 'present',
          :profile_acls    => false,
        }}
        let(:change_set) { default_changes.with("profile acls", "no") }
      end

      context 'with store_dos_attributes set to true' do
        include_examples "default share"
        let(:params) {{
          :ensure               => 'present',
          :store_dos_attributes => true,
        }}
        let(:change_set) { default_changes.with("store dos attributes", "yes") }
      end

      context 'with store_dos_attributes set to false' do
        include_examples "default share"
        let(:params) {{
          :ensure               => 'present',
          :store_dos_attributes => false,
        }}
        let(:change_set) { default_changes.with("store dos attributes", "no") }
      end

      context 'with strict_allocate set to true' do
        include_examples "default share"
        let(:params) {{
          :ensure          => 'present',
          :strict_allocate => true,
        }}
        let(:change_set) { default_changes.with("strict allocate", "yes") }
      end

      context 'with strict_allocate set to false' do
        include_examples "default share"
        let(:params) {{
          :ensure          => 'present',
          :strict_allocate => false,
        }}
        let(:change_set) { default_changes.with("strict allocate", "no") }
      end

      context 'with valid_users set to "bill,ben"' do
        include_examples "default share"
        let(:params) {{
          :ensure      => 'present',
          :valid_users => 'bill,ben',
        }}
        let(:change_set) { default_changes.with("valid users", "'bill,ben'") }
      end

      context 'with op_locks set to "testing"' do
        include_examples "default share"
        let(:params) {{
          :ensure   => 'present',
          :op_locks => 'testing',
        }}
        let(:change_set) { default_changes.with("oplocks", "'testing'") }
      end

      context 'with level2_oplocks set to "testing"' do
        include_examples "default share"
        let(:params) {{
          :ensure         => 'present',
          :level2_oplocks => 'testing',
        }}
        let(:change_set) { default_changes.with("level2 oplocks", "'testing'") }
      end

      context 'with veto_oplock_files set to "testing"' do
        include_examples "default share"
        let(:params) {{
          :ensure            => 'present',
          :veto_oplock_files => 'testing',
        }}
        let(:change_set) { default_changes.with("veto oplock files", "'testing'") }
      end

      context 'with write_list set to "bill,ben"' do
        include_examples "default share"
        let(:params) {{
          :ensure     => 'present',
          :write_list => 'bill,ben',
        }}
        let(:change_set) { default_changes.with("write list", "'bill,ben'") }
      end

      context 'with hide_dot_files set to true' do
        include_examples "default share"
        let(:params) {{
          :ensure         => 'present',
          :hide_dot_files => true,
        }}
        let(:change_set) { default_changes.with("hide dot files", "yes") }
      end

      context 'with hide_dot_files set to false' do
        include_examples "default share"
        let(:params) {{
          :ensure         => 'present',
          :hide_dot_files => false,
        }}
        let(:change_set) { default_changes.with("hide dot files", "no") }
      end

      context 'with root_preexec set to "/bin/test"' do
        include_examples "default share"
        let(:params) {{
          :ensure       => 'present',
          :root_preexec => '/bin/test',
        }}
        let(:change_set) { default_changes.with("root preexec", "'/bin/test'") }
      end
    end
  end
end
