require "./spec_helper"
require "process"

describe Collectd::Unixsock do
  it "putval on running collectd" do
    run_collectd_server do |socket_path|
      collectd = Collectd::Unixsock.open("/tmp/collectd-cr-test.socket")
      status, message = collectd.putval("testval/cpu-0/cpu-idle",
                                        [Collectd::Unixsock::ValueListOption::CurrentTime, 2323])
      status.should eq 0
      message.should eq "Success: 1 value has been dispatched."
    end
  end
end

def run_collectd_server
  socket_path = File.tempfile("collectd-socket", ".socket").path

  conffile = File.tempfile("collectd-conf")
  conffile_path = conffile.path
  conffile.puts("
BaseDir \"/tmp\"
PIDFile \"#{socket_path}\"
#Interval 10.0

LoadPlugin cpu
LoadPlugin load

LoadPlugin unixsock

<Plugin unixsock>
  SocketFile \"#{socket_path}\"
  SocketGroup \"nobody\"
  SocketPerms \"0777\"
  DeleteSocket true
</Plugin>

")

  collectd_server = Process.new("collectd", ["-B", "-f", "-C", conffile_path])
  yield socket_path
  collectd_server.terminate()
rescue
  unless collectd_server.nil?
    collectd_server.terminate()
  end
else
  conffile.delete
end
