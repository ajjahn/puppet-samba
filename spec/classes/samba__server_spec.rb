require 'spec_helper'

describe 'samba::server' do
  let(:facts) {{ :osfamily => 'Debian' }}

  it { should contain_class('samba::server::install') }
  it { should contain_class('samba::server::config') }
  it { should contain_class('samba::server::service') }

  it { should contain_samba__server__option('interfaces') }
  it { should contain_samba__server__option('bind interfaces only') }
  it { should contain_samba__server__option('security') }
  it { should contain_samba__server__option('server string') }
  it { should contain_samba__server__option('unix password sync') }
  it { should contain_samba__server__option('workgroup') }
  it { should contain_samba__server__option('socket options') }
  it { should contain_samba__server__option('deadtime') }
  it { should contain_samba__server__option('keepalive') }
  it { should contain_samba__server__option('load printers') }
  it { should contain_samba__server__option('printing') }
  it { should contain_samba__server__option('printcap name') }
  it { should contain_samba__server__option('disable spoolss') }

  context 'with hiera shares hash' do
    let(:params) {{
        'shares' => {
          'testShare' => {
            'path' => '/path/to/some/share',
            'browsable' => true,
            'writable' => true,
            'guest_ok' => true,
            'guest_only' => true,
            'msdfs_root' => true,
         },
         'testShare2' => {
            'path' => '/some/other/path'
         }
       }
    }}
    it { 
      should contain_samba__server__share( 'testShare' ).with({
          'path' => '/path/to/some/share',
          'browsable' => true,
          'writable' => true,
          'guest_ok' => true,
          'guest_only' => true,
          'msdfs_root' => true,
      })
    }
    it { should contain_samba__server__share( 'testShare2' ).with_path('/some/other/path') }
  end

  context 'with hiera users hash' do
    let(:params) {{
        'users' => {
          'testUser' => {
            'password' => 'testpass01'
         },
         'testUser2' => {
            'password' => 'testpass02'
         }
       }
    }}
    it { should contain_samba__server__user( 'testUser' ).with_password('testpass01') }
    it { should contain_samba__server__user( 'testUser2' ).with_password('testpass02') }
  end

end
