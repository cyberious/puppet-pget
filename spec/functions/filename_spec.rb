require 'spec_helper'

describe "the pget_filename function" do
  let(:scope) { PuppetlabsSpec::PuppetInternals.scope }

  it "should exist" do
    Puppet::Parser::Functions.function("pget_filename").should == "function_pget_filename"
  end
  it "should return msi file" do
    ["c:/Program Files/puppet-3.4.1.msi","http://downloads.puppetlabs.com/windows/puppet-3.4.1.msi","puppet://extra_files/puppet-3.4.1.msi"].each {|item|
      result = scope.function_pget_filename([item])
      result.should(eq("puppet-3.4.1.msi"))
    }
  end
end

