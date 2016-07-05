require 'spec_helper'

describe 'samba::server::share', :type => :define do
  let(:pre_condition){ 'class{"samba::server":}'}
  on_supported_os.each do |os, facts|
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
          :changes => ["set target[. = 'test_share'] 'test_share'"]
          ).that_requires('Class[Samba::Server::Config]'
          ).that_notifies('Class[Samba::Server::Service]')
        }
        it { is_expected.to contain_augeas('test_share-changes').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          ).that_requires('Class[Samba::Server::Config]'
          ).that_notifies('Class[Samba::Server::Service]')
        }
      end#no params

      context 'when called with ensure set to absent' do
        let(:title) { 'test_share' }
        let(:params) {{
          :ensure => 'absent'
        }}

        it 'should not contain the share'  do
          skip 'this is not working'
          should_not contain_samba__server__share('test_share')
        end
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
          :changes => ["set target[. = 'test_share'] 'test_share'"]
          ).that_requires('Class[Samba::Server::Config]'
          ).that_notifies('Class[Samba::Server::Service]')
        }
        it { is_expected.to contain_augeas('test_share-changes').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => ["set \"target[. = 'test_share']/available\" yes"]
          ).that_requires('Class[Samba::Server::Config]'
          ).that_notifies('Class[Samba::Server::Service]')
        }
      end#no params

      context 'when called with root_preexec set to something' do
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
          :changes => ["set target[. = 'test_share'] 'test_share'"]
          ).that_requires('Class[Samba::Server::Config]'
          ).that_notifies('Class[Samba::Server::Service]')
        }
        it { is_expected.to contain_augeas('test_share-changes').with(
          :incl    => '/etc/samba/smb.conf',
          :lens    => 'Samba.lns',
          :context => '/files/etc/samba/smb.conf',
          :changes => ["set \"target[. = 'test_share']/root_preexec\" /bin/true"]
          ).that_requires('Class[Samba::Server::Config]'
          ).that_notifies('Class[Samba::Server::Service]')
        }
      end#no params

    end
  end
end

