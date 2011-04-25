require 'test_helper'

# member vars
#   - address : String, unique, max length = 40
#   - password : String,        max length = 40
#   - host : String,            max length = 40
#   - port : integer, range: [0, 65535]

# all members modifiable, required
class MailServerTest < ActiveSupport::TestCase
  
  test "Missing address" do
    mailServer = MailServer.new(:password => "aSimplePassword", :host => "smtp.web.de", :port => 80)
    assert !(mailServer.save()), 'address required'
  end
  
  test "Missing password" do
    mailServer = MailServer.new(:address => "aSimpleAddress@web.de", :host => "smtp.web.de", :port => 80)
    assert !(mailServer.save()), 'password required'
  end
  
  test "Missing host" do
    mailServer = MailServer.new(:address => "aSimpleAddress@web.de", :password => "aSimplePassword",:port => 80)
    assert !(mailServer.save()), 'host required'
  end
  
  test "Missing port" do
    mailServer = MailServer.new(:address => "aSimpleAddress@web.de", :password => "aSimplePassword", :host => "smtp.web.de")
    assert !(mailServer.save()), 'port required'
  end
  
  
  
end
