require 'spec_helper'

describe 'samba::server' do
  let(:facts) {{ :osfamily => 'Debian' }}

  it { should contain_class('samba::server::install') }
  it { should contain_class('samba::server::config') }
  it { should contain_class('samba::server::service') }
end
