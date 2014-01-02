require 'spec_helper'

describe "the build_download_cmd function" do
  let(:scope) { PuppetlabsSpec::PuppetInternals.scope }

  it "should exist" do
    Puppet::Parser::Functions.function("build_download_cmd").should == "function_build_download_cmd"
  end
  it "should provide proper cmd" do
    result = scope.function_build_download_cmd([{:source => "http://mydomain.com/puppet-3.4.1.msi",:target_file => "C:/stage/puppet-3.4.1.msi"},])
    result.should(eq("\$wc = New-Object System.Net.WebClient;\$wc.DownloadFile('http://mydomain.com/puppet-3.4.1.msi','C:/stage/puppet-3.4.1.msi')"))
  end
end

