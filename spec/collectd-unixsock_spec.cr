require "./spec_helper"
require "socket"

# see https://collectd.org/documentation/manpages/collectd-unixsock.5.shtml
describe Collectd::Unixsock do

  it "putval to unixsock" do
    tmpsocket = File.tempfile("collectd-unixsock-cr", ".sock")
    socket_path = tmpsocket.path
    tmpsocket.delete

    server = UNIXServer.new(socket_path)
    spawn do
      client = server.accept?
      if !client.nil?
        line = client.gets
        line.should eq "PUTVAL testval/cpu-0/cpu-idle N:2323"
        client.puts "0 Success"
      end
      server.close
    end

    collectd = Collectd::Unixsock.open(socket_path)
    status, message = collectd.putval("testval/cpu-0/cpu-idle",
                                      [Collectd::Unixsock::ValueListOption::CurrentTime, 2323])
    status.should eq 0
    message.should eq "Success"
    collectd.close
  end
end
