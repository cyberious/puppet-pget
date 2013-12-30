require 'spec_helper'

describe 'pget' do
  let(:title){'Download Puppet'}
  let(:params){{:source => "http://downloads.puppetlabs.com/windows/puppet-3.4.1.msi",:target => "C:/software/"}}
  describe 'Download msi' do
    it{
      should contain_exec('Download-puppet-3.4.1.msi').with_provider('powershell')
    }
  end


end