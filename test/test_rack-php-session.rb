require 'helper'
require 'yaml'

class TestRackPhpSession < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    @app = Rack::Builder.new {
      use Rack::PhpSession, :session_file_path => File.join(File.dirname(__FILE__), 'fixtures')
      run lambda {|env| [200,  {'Content-Type' =>  'text/plain', 'Content-Length' => '12'}, ["Hello World!"] ] }
    }.to_app
  end

  def test_no_php_session_without_cookie
    get '/'
    assert ! last_request.env.include?('php.session')
  end

  def test_php_session_with_cookie
    get '/', nil, { 'HTTP_COOKIE' => 'PHPSESSID=b6c1556e31e663f35b042c8b8369b75e' }
    assert last_request.env.include?('php.session')
  end

  def test_php_session_hash_is_valid
    get '/', nil, { 'HTTP_COOKIE' => 'PHPSESSID=b6c1556e31e663f35b042c8b8369b75e' }
    assert_equal Hash["uid" => "1", "upw" => "fc34cbc639d6f616f6a43daa3451ab7a"], last_request.env['php.session']
  end

  def test_empty_session_file_should_return_empty_hash
    get '/', nil, { 'HTTP_COOKIE' => 'PHPSESSID=empty' }
    assert_equal Hash.new, last_request.env['php.session']
  end
end
