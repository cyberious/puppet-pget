require 'spec_helper'

describe 'pget' do
  let(:title){'Download Puppet'}
  let(:facts){{:operatingsystem => "Windows"}}


  shared_context 'http' do
    let(:params){{:source => "http://downloads.puppetlabs.com/windows/puppet-3.4.1.msi",:target => "C:/software/"}}
  end
  shared_context 'ftp with pass' do
    let(:params){{:password => 'testme',:username => 'testuser',:source => "ftp://downloads.puppetlabs.com/windows/puppet-3.4.1.msi",:target => "C:/software/"}}
  end

  describe 'Download msi' do
    include_context 'http'
    it{
      should contain_exec('Download-puppet-3.4.1.msi'){
        with_provider('powershell')
        with_command("\$wc = New-Object System.Net.WebClient; \$wc.DownloadFile('http://downloads.puppetlabs.com/windows/puppet-3.4.1.msi','C:/software/puppet-3.4.1.msi')")
      }
    }
  end
  describe 'Download with password' do
    include_context 'ftp with pass'
    it{
      should contain_exec('Download-puppet-3.4.1.msi'){
        with_provider('powershell')
        with_command("\$wc = New-Object System.Net.WebClient;\$wc.Credentials = New-Object System.Net.NetworkCredential('testuser','testme');\$wc.DownloadFile('ftp://downloads.puppetlabs.com/windows/puppet-3.4.1.msi','C:/software/puppet-3.4.1.msi')")
      }
    }
  end
  describe 'Attempt using with Ubuntu' do
       include_context 'http'
       let(:facts){{:operatingsystem => 'Debian'}}
    it{
      expect {
        should contain_exec("Download-puppet-3.4.1.msi")
      }.to raise_error(Puppet::Error, /Unsupported OS Debian/)
    }
  end



end