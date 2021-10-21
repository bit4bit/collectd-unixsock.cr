module Collectd::Unixsock
  class Protocol
    # https://collectd.org/documentation/manpages/collectd-unixsock.5.shtml#putval_identifier_optionlist_valuelist
    def putval(identifier_name : String, values : ValueList, options = OptionList.new)
      String.build do |str|
        str << "PUTVAL "
        str << encode_identifier(Identifier.from_string(identifier_name))

        options_encoded = encode_options(options)
        if options_encoded != ""
          str << " "
          str << options_encoded
        end

        str << " "
        str << encode_values(values)
      end
    end

    private def encode_options(options : OptionList)
      options.map { |k, v|
        if "#{v}".includes?(' ')
          "#{k}=\"#{v}\""
        else
          "#{k}=#{v}"
        end
      }.join(" ")
    end

    private def encode_values(values : ValueList)
      values.join(":")
    end

    private def encode_identifier(identifier : Identifier)
      out = "#{identifier.hostname}/#{identifier.plugin}/#{identifier.type}"
      if out.includes?(' ')
        "\"#{out}\""
      else
        out
      end
    end
  end
end
