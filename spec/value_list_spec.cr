require "./spec_helper"

describe Collectd::Unixsock::ValueList do

  it "option list from hash" do
    values = Collectd::Unixsock::ValueList.new()
    values << 1
    values << 2.0
    values << Collectd::Unixsock::ValueListOption::Undefined
    values << Collectd::Unixsock::ValueListOption::CurrentTime
    values << 3.0
    values << 4

    values[0].should eq 1
    values[1].should eq 2.0
    values[2].should eq Collectd::Unixsock::ValueListOption::Undefined
    values[3].should eq Collectd::Unixsock::ValueListOption::CurrentTime
    values[4].should eq 3.0
    values[5].should eq 4
  end
end
