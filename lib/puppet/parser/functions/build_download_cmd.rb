module Puppet::Parser::Functions
  newfunction(:build_download_cmd, :type  => :rvalue, :doc => <<-EOS
Returns the powerhell command for downloading file, requires hash to form command
  EOS
  ) do |args|
    raise(Puppet::ParseError, "build_download_cmd(): Wrong number of arguments " +
        "given (#{args.size} for 1") if args.size != 1
    @cmd = "\$wc = New-Object System.Net.WebClient;"
    @params = {}

    begin
      @params = Hash.try_convert(args[0])
      rescue
      raise(Puppet::ParseError, "build_download_cmd(): requires hash as argument ")
    end

    if @params['username'] and @params['password']
      @cmd += "\$wc.Credentials = New-Object System.Net.NetworkCredential('#{@params['username']}','#{@params['password']}');"
    end

    if @params['header']
      begin
        @header = Hash.try_convert @params['header']
          @header.each do |k,v|
            @cmd += "\$wc.Headers.Add('#{k}','#{v}');"
          end
      rescue
        raise(Puppet::ParserError,"Unable tp parse header options to build config")
      end
    end
    @cmd += "\$wc.DownloadFile('#{@params['source']}','#{@params['target_file']}')"
    return @cmd
  end
end