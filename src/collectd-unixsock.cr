# TODO: Write documentation for `Collectd::Unixsock`
module Collectd::Unixsock
  VERSION = "0.1.0"

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

    def to_s
      out = "#{@hostname}/#{@plugin}/#{@type}"
      if out.includes?(' ')
        "\"#{out}\""
      else
        out
      end
    end
  end
end
