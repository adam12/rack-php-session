rack-php-session
================

Exposes a PHP session (read-only) to Rack applications


Installation
------------
      gem install rack-php-session


Dependencies
------------
* [php-serialize](http://www.aagh.net/projects/ruby-php-serialize)


Usage
-----
In your rackup file

      use Rack::PhpSession


In your application

      env['php.session'] => { } # Returns a Hash of the PHP Session contents


Limitations
-----------
* The PHP session is currently read-only.
* The Rack application must be able to read PHP session files. In PHP configurations
  that utilize suPHP, this is trivial as session files are stored as the current user.
  Standard mod_php configurations may result in permission problems.
* The PHP Session ID must be known -- this is generally stored in a cookie so the Rack
  application must run on the same domain as the PHP application (easily achievable
  using Passenger or a Proxy method).


Note on Patches/Pull Requests
-----------------------------
* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.


Copyright
---------
Copyright (c) 2010 Adam Daniels. See LICENSE for details.
