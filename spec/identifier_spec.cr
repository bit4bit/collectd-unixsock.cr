require "./spec_helper"

# see https://collectd.org/documentation/manpages/collectd-unixsock.5.shtml
describe Collectd::Unixsock::Identifier do

  it "identifier from string" do
    ident = Collectd::Unixsock::Identifier.from_string("localhost/test/load")

    ident.hostname.should eq "localhost"
    ident.plugin.should eq "test"
    ident.type.should eq "load"
  end

  it "identifier from string when have spaces" do
    ident = Collectd::Unixsock::Identifier.from_string("localhost/test/load 1")

    ident.hostname.should eq "localhost"
    ident.plugin.should eq "test"
    ident.type.should eq "load 1"
  end

  it "fail with invalid identifier" do
    expect_raises(Collectd::Unixsock::Identifier::Error) do
      Collectd::Unixsock::Identifier.from_string("localhost/test|load")
    end
  end
end
