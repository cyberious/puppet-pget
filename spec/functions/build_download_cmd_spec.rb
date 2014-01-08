require 'spec_helper'

describe "the build_download_cmd function" do
  let(:scope) { PuppetlabsSpec::PuppetInternals.scope }

  it "should exist" do
    Puppet::Parser::Functions.function("build_download_cmd").should == "function_build_download_cmd"
  end
  it "should provide proper cookie and useragent" do
    result = scope.function_build_download_cmd([{"user-agent"=>"Cookie Monster","Cookie"=>"We got chocolate chips"},])
    result.should(eq("\$wc.Headers.Add('user-agent','Cookie Monster');\$wc.Headers.Add('Cookie','We got chocolate chips');"))
  end
end

