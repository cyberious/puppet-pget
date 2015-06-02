require 'spec_helper'

describe "the build_header_cmd function" do
  let(:scope) { PuppetlabsSpec::PuppetInternals.scope }

  it "should exist" do
    expect(Puppet::Parser::Functions.function("build_header_cmd")).to eq("function_build_header_cmd")
  end
  it "should provide proper cookie and useragent" do
    result = scope.function_build_header_cmd([{"user-agent" => "Cookie Monster", "Cookie" => "We got chocolate chips"},])
    expect(result).to(eq("\$wc.Headers.Add('user-agent','Cookie Monster');\$wc.Headers.Add('Cookie','We got chocolate chips');"))
  end
end

