require 'php_serialize'

module Rack
  class PhpSession
    def initialize(app, options = {})
      @app = app
      @options = { :session_name => 'PHPSESSID', :session_file_path => '.' }.merge(options)
    end

    def call(env, options = {})
      req = Request.new(env)

      session_id = req.cookies[@options[:session_name]]
      session_file = ::File.join(@options[:session_file_path], "sess_#{session_id}")

      if ::File.exists?(session_file)
        env['php.session'] = PHP.unserialize(::File.read(session_file))
      end
      
      @app.call(env)
    end
  end
end
