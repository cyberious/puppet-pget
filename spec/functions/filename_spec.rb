require 'spec_helper'

describe "the pget_filename function" do
  let(:scope) { PuppetlabsSpec::PuppetInternals.scope }

  it "should exist" do
    expect(Puppet::Parser::Functions.function("pget_filename")).to eq("function_pget_filename")
  end
  it "should return msi file" do
    ["c:/Program Files/puppet-3.4.1.msi", "http://downloads.puppetlabs.com/windows/puppet-3.4.1.msi", "puppet://extra_files/puppet-3.4.1.msi", "http://downloads.puppetlabs.com/windows/puppet-3.4.1.msi?parameter1=value1&parameter2=value2"].each { |item|
      result = scope.function_pget_filename([item])
      expect(result).to(eq("puppet-3.4.1.msi"))
    }
  end
end

