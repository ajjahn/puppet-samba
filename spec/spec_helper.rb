require 'puppetlabs_spec_helper/module_spec_helper'
require 'rspec-puppet-facts'

Dir[File.expand_path("../support/**/*.rb", __FILE__)].each { |f| require f }

include RspecPuppetFacts

RSpec.configure do |c|
  c.before do
    # avoid "Only root can execute commands as other users"
    Puppet.features.stubs(:root? => true)
  end
end

at_exit { RSpec::Puppet::Coverage.report! }
