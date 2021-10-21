require "./spec_helper"

describe Collectd::Unixsock::Protocol do

  it "encode putval" do
    encoded = Collectd::Unixsock::Protocol::PUTVAL.command(
      "testhost/interface/if_octets-test0",
      [1179574444,123,456],
      {"interval" => 10}
    )

    encoded.should eq "PUTVAL testhost/interface/if_octets-test0 interval=10 1179574444:123:456"
  end

  it "encode putval undefined" do
    encoded = Collectd::Unixsock::Protocol::PUTVAL.command(
      "testhost/interface/if_octets-test0",
      [Collectd::Unixsock::ValueListOption::Undefined, 3],
      {"interval" => 10}
    )

    encoded.should eq "PUTVAL testhost/interface/if_octets-test0 interval=10 U:3"
  end

  it "encode putval current time" do
    encoded = Collectd::Unixsock::Protocol::PUTVAL.command(
      "testhost/interface/if_octets-test0",
      [Collectd::Unixsock::ValueListOption::CurrentTime, 3],
      {"interval" => 10}
    )

    encoded.should eq "PUTVAL testhost/interface/if_octets-test0 interval=10 N:3"
  end

  it "encode putval quote option value with space" do
    encoded = Collectd::Unixsock::Protocol::PUTVAL.command(
      "testhost/interface/if_octets-test0",
      [1179574444,123,456],
      {"interval" => 10, "test" => "has space"},
    )

    encoded.should eq "PUTVAL testhost/interface/if_octets-test0 interval=10 test=\"has space\" 1179574444:123:456"
  end

  it "encode putval quote identifier with space" do
    encoded = Collectd::Unixsock::Protocol::PUTVAL.command(
      "testhost/interface/if_octets test0",
      [1179574444,123,456],
      {"interval" => 10, "test" => "has space"},
    )

    encoded.should eq "PUTVAL \"testhost/interface/if_octets test0\" interval=10 test=\"has space\" 1179574444:123:456"
  end

  it "parse answer" do
    status, message = Collectd::Unixsock::Protocol::PUTVAL.answer("0 Success")

    status.should eq 0
    message.should eq "Success"
  end
end
