module Puppet::Parser::Functions
  newfunction(:build_header_cmd, :type  => :rvalue, :doc => <<-EOS
Returns the powerhell command for downloading file, requires hash to form command
  EOS
  ) do |args|
    raise(Puppet::ParseError, "build_header_cmd(): Wrong number of arguments " +
        "given (#{args.size} for 1") if args.size != 1
   begin
    @header = Hash.try_convert args[0]
    @cmd = ""
    @header.each do |k,v|
      @cmd += "\$wc.Headers.Add('#{k}','#{v}');"
    end
    rescue
      raise(Puppet::ParserError,"Unable tp parse header options to build config")
  end
  return @cmd
  end
end