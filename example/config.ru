require 'rubygems'
require File.join(File.dirname(__FILE__), '..', 'lib', 'rack/php-session')
require 'sinatra/base'

use Rack::Reloader
use Rack::Lint
use Rack::ShowExceptions
use Rack::PHPSession

class App < Sinatra::Base
  get '/' do
    "<pre>" + env.to_yaml + "</pre>"
  end
end

map '/' do
  run App.new
end
