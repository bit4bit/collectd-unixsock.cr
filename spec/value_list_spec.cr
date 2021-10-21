require "./spec_helper"

describe Collectd::Unixsock::ValueList do

  it "option list from hash" do
    values = Collectd::Unixsock::ValueList.new()
    values << 1
    values << 2.0
    values << nil
    values << 3.0
    values << 4

    values[0].should eq 1
    values[1].should eq 2.0
    values[2].should eq nil
    values[3].should eq 3.0
    values[4].should eq 4
  end
end
