require 'php_serialize'

module Rack
  # Exposes a PHP Session in Rack Applications as a Hash

  class PHPSession
    # @param [Hash] options the options to configure the middleware
    # @option options [String] :session_name ('PHPSESSID') The name of the PHP Session
    # @option options [String] :session_file_path ('.') The folder where PHP Session files are stored

    def initialize(app, options = {})
      @app = app
      @options = { :session_name => 'PHPSESSID', :session_file_path => '.' }.merge(options)
    end

    def call(env, options = {})
      req = Request.new(env)

      session_id = req.cookies[@options[:session_name]]
      session_file = ::File.join(@options[:session_file_path], "sess_#{session_id}")

      if ::File.exists?(session_file)
        contents = ::File.read(session_file)
        env['php.session'] = (contents.nil? || contents.empty?) ? Hash.new : PHP.unserialize(contents)
      end
      
      @app.call(env)
    end
  end
end
