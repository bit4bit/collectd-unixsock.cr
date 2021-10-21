# TODO: Write documentation for `Collectd::Unixsock`
require "./collectd-unixsock/protocol"
require "./collectd-unixsock/types"
require "./collectd-unixsock/connect_socket"

module Collectd::Unixsock
  VERSION = "0.1.0"

  def self.open(socket_path)
    ConnectSocket.new(socket_path)
  end
end
