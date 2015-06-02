module Puppet::Parser::Functions
  newfunction(:build_header_cmd, :type => :rvalue, :doc => <<-EOS
Returns the powerhell command for downloading file, requires hash to form command
  EOS
  ) do |args|
    raise(Puppet::ParseError, "build_header_cmd(): Wrong number of arguments " +
        "given (#{args.size} for 1") if args.size != 1
    @@cmd = ""

    @@header = args[0]
    debug("#{@@header} was passed to function")
    @@header.each do |k, v|
      @@cmd += "\$wc.Headers.Add('#{k}','#{v}');"
      debug("#{@@cmd} is built so far")
    end
    return @@cmd
  end
end
