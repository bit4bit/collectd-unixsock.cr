# TODO: Write documentation for `Collectd::Unixsock`
module Collectd::Unixsock
  VERSION = "0.1.0"

  class ValueList
    # nil present gauge value undefined or U
    @values = Array(Int32 | Int64 | Float32 | Float64 | Nil).new

    def <<(value)
      @values << value
    end

    def [](key)
      @values[key]
    end
  end

  class OptionList
    alias OptionListHash = Hash(String, String | Int32)

    def initialize(@options = OptionListHash.new)
    end

    def self.from_hash(hash : Hash(String, String | Int32))
      opts = OptionListHash.new
      hash.each do |k, v|
        opts[k] = v
      end

      self.new(opts)
    end

    def [](key)
      @options[key]
    end

    def each(&block)
      @options.each do |k, v|
        block(k, v)
      end
    end
  end

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
