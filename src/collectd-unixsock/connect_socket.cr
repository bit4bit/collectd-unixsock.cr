require "socket"

module Collectd::Unixsock
  class ConnectSocket
    class Error < Exception
    end

    @socket : UNIXSocket | Nil = nil

    def initialize(socket_path : String)
      @socket = UNIXSocket.new(socket_path)
    rescue
      raise Error.new("failed to open socket #{socket_path}")
    end

    def putval(identifier, values : Collectd::Unixsock::ValueList, options  = Collectd::Unixsock::OptionList.new())
      exec = Collectd::Unixsock::Protocol::PUTVAL

      cmd = exec.command(identifier, values, options)
      socket.puts cmd

      response = socket.gets
      if response.nil?
        raise "fail response for #{cmd}"
      end

      exec.answer(response)
    end

    def close
      socket.close
    end

    private def socket
      if @socket.nil?
        raise "socket nil please open again"
      end
      @socket.as(UNIXSocket)
    end
  end
end
