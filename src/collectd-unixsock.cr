# TODO: Write documentation for `Collectd::Unixsock`
require "./collectd-unixsock/protocol"

module Collectd::Unixsock
  VERSION = "0.1.0"

  # nil present gauge value undefined or U
  alias ValueList = Array(Int32 | Int64 | Float32 | Float64 | Nil)
  alias OptionList = Hash(String, String | Int32)

  class Identifier
    class Error < Exception
    end

    getter hostname
    getter plugin
    getter type

    def initialize(@hostname : String, @plugin : String, @type : String)
    end

    def self.from_string(path)
      hostname, plugin, type_ = path.split('/', 3)
      self.new(hostname, plugin, type_)
    rescue
      raise Error.new("can't parse path #{path}")
    end
  end
end
