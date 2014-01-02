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

      if @params[:username] or @params[:password]
        @cmd += "\$wc.Credentials = New-Object System.Net.NetworkCredential('${username}','${password}');"
      end
      if @params[:header]

      end

      @cmd += "\$wc.DownloadFile('#{@params[:source]}','#{@params[:target_file]}')"

    rescue
      raise(Puppet::ParseError, "build_download_cmd(): requires hash as argument ")
    end
    return @cmd
  end
end