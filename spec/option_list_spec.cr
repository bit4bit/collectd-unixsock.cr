require "./spec_helper"

describe Collectd::Unixsock::OptionList do

  it "option list from hash" do
    opts = Collectd::Unixsock::OptionList.from_hash({"interval" => 33})
    opts["interval"].should eq 33
  end
end
