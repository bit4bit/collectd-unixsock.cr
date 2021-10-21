require "./spec_helper"

describe Collectd::Unixsock::Protocol do

  it "encode putval" do
    protocol = Collectd::Unixsock::Protocol.new

    encoded = protocol.putval(
      "testhost/interface/if_octets-test0",
      [1179574444,123,456],
      {"interval" => 10}
    )

    encoded.should eq "PUTVAL testhost/interface/if_octets-test0 interval=10 1179574444:123:456"
  end

  it "encode putval quote option value with space" do
    protocol = Collectd::Unixsock::Protocol.new

    encoded = protocol.putval(
      "testhost/interface/if_octets-test0",
      [1179574444,123,456],
      {"interval" => 10, "test" => "has space"},
    )

    encoded.should eq "PUTVAL testhost/interface/if_octets-test0 interval=10 test=\"has space\" 1179574444:123:456"
  end

  it "encode putval quote identifier with space" do
    protocol = Collectd::Unixsock::Protocol.new

    encoded = protocol.putval(
      "testhost/interface/if_octets test0",
      [1179574444,123,456],
      {"interval" => 10, "test" => "has space"},
    )

    encoded.should eq "PUTVAL \"testhost/interface/if_octets test0\" interval=10 test=\"has space\" 1179574444:123:456"
  end
end
