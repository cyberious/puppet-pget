require 'spec_helper_acceptance'

describe 'pget', :unless => UNSUPPORTED_PLATFORMS.include?(fact('operatingsystem')) do
  describe 'it should download puppet via http' do
    it 'should run without error' do
    pp = <<-EOS
      pget {'http://downloads.puppetlabs.com/windows/puppet-2.7.21.msi':
        path => 'C:/software/puppet-2.7.21.msi'
      }
    EOS

    apply_manifest(pp,:catch_failures => true)
      end
    describe file('C:/software/puppet-2.7.21.msi') do
      it {
        should be_file
      }
      end
  end
end